# Codex CLI Agent Team機能 実装提案書

**作成日**: 2026年2月18日
**チーム**: codex-team-research（調査員3名・レビュアー2名・まとめ担当1名）

---

## 目次

1. [エグゼクティブサマリー](#1-エグゼクティブサマリー)
2. [現状分析](#2-現状分析)
3. [調査結果詳細](#3-調査結果詳細)
4. [レビュー結果詳細](#4-レビュー結果詳細)
5. [提案するアーキテクチャ（3案比較）](#5-提案するアーキテクチャ3案比較)
6. [推奨アプローチとその理由](#6-推奨アプローチとその理由)
7. [実装ロードマップ](#7-実装ロードマップ)
8. [具体的なコード例](#8-具体的なコード例)
9. [リスクと対策](#9-リスクと対策)
10. [結論](#10-結論)

---

## 1. エグゼクティブサマリー

OpenAI Codex CLIは現在Rustに全面リライトされた高性能なAIコーディングアシスタントだが、Claude Codeのようなネイティブなマルチエージェント協調（Agent Team）機能を持たない。本提案書では、Codex CLIにAgent Team機能を追加するための3つのアーキテクチャアプローチを比較評価し、**OpenAI Agents SDK + Codex MCPサーバーを起点としたハイブリッド段階的実装**を推奨する。このアプローチにより、最短1-2週間でPoCを実現し、段階的にgit worktreeベースの並列開発、ファイルベースのタスク管理、宣言的な設定ファイルシステムへと進化させることができる。Claude Codeとの最大の差別化要素は、**ユーザー主導の宣言的チーム制御**と**git worktreeによる完全分離された並列開発**である。

---

## 2. 現状分析

### 2.1 Codex CLIの現状

| 項目 | 詳細 |
|------|------|
| **言語** | Rust（96%）、65クレートのCargoワークスペース |
| **アーキテクチャ** | 3層構造：UI層（TUI/Exec/JSON-RPC）→ codex-core → 外部統合（ModelClient/MCP/Process） |
| **通信プロトコル** | キューベース（Op投入→Event受信、JSONL形式） |
| **MCPサーバー** | `codex mcp-server`で`codex()`と`codex_reply()`の2ツール公開 |
| **SDK** | `@openai/codex-sdk`（TypeScript）でstdin/stdout JSONL経由制御 |
| **拡張機構** | SKILL.md（タスク特化パッケージ）、AGENTS.md（リポジトリレベル指示） |
| **並行処理** | ThreadManager（並行スレッド管理あり、ただしエージェント間メッセージングなし） |
| **Team機能** | **未実装** |

### 2.2 Claude Code Agent Teamsとの比較表

| 観点 | Codex CLI（現状） | Claude Code Agent Teams |
|------|-------------------|------------------------|
| **チーム作成** | なし | TeamCreate ツール |
| **タスク管理** | なし | TaskCreate/Get/List/Update |
| **エージェント間通信** | なし | SendMessage（DM/broadcast） |
| **タスク依存関係** | なし | blocks/blockedBy、自動アンブロック |
| **状態管理** | なし | ファイルベース（~/.claude/teams/, ~/.claude/tasks/） |
| **実行バックエンド** | 単一プロセス | in-process / tmux / iTerm2 |
| **コンテキスト分離** | 単一コンテキスト | 各エージェントが独立コンテキストウィンドウ |
| **プロトコル** | なし | shutdown/plan_approval プロトコル |
| **Hooks** | なし | TeammateIdle, TaskCompleted フック |
| **オーケストレーション** | なし | 並列スペシャリスト/パイプライン/スウォーム等 |
| **制御モデル** | — | AI自律型（AIがTeamCreateを呼ぶ） |
| **設定ファイル** | config.toml（基本設定のみ） | なし（全てツール呼び出し） |
| **並列開発** | — | 同一ディレクトリ |
| **Git統合** | worktree対応 | ファイルベース管理 |

### 2.3 現在のギャップ

1. **エージェント間協調機構の欠如**: ThreadManagerは並行スレッド管理を持つが、エージェント間メッセージングやタスク分配の仕組みがない
2. **チーム状態管理の欠如**: チーム構成、タスクリスト、進捗管理のための永続化機構がない
3. **オーケストレーションレイヤーの欠如**: 複数エージェントの起動・停止・監視を統括するコンポーネントがない
4. **CLIコマンドの欠如**: `codex team`等のサブコマンド体系が存在しない

---

## 3. 調査結果詳細

### 3.1 Codex CLIアーキテクチャ（調査員1: researcher-codex）

#### 3層レイヤードアーキテクチャ

**Tier 1 - UIレイヤー:**
- TUI（Ratatui ベースのフルスクリーンターミナルUI）
- Exec（ヘッドレス自動化モード）
- JSON-RPC 2.0 APIサーバー（IDE拡張用）

**Tier 2 - コアビジネスロジック（codex-core）:**
- `Codex` キュー・インターフェース（submit/eventフロー処理）
- `Session` 会話ライフサイクル・ターン実行管理
- `ThreadManager` 並行会話のオーケストレーション

**Tier 3 - 外部統合:**
- `ModelClient` (OpenAI/Ollama/LMStudioとの通信)
- `McpConnectionManager` (外部MCPツールサーバー集約)
- `UnifiedExecProcessManager` (PTYサポート付き長寿命プロセス管理)
- `RolloutRecorder` (JSONLファイルへのセッション状態永続化)

#### Cargoワークスペース構成（65クレート）

| クレート | 役割 |
|---------|------|
| `core/` | ビジネスロジック（再利用可能ライブラリ） |
| `exec/` | ヘッドレスCLI自動化用 |
| `tui/` | Ratatuiフレームワーク使用のフルスクリーンTUI |
| `cli/` | マルチツールサブコマンドディスパッチャー |
| `app-server/` | JSON-RPC 2.0 API（stdio/WebSocket） |
| `mcp-server/` | MCPプロトコルサーバー実装 |
| `apply-patch/` | diff解析・コード変更 |
| `execpolicy/` | 承認ルールエンジン |
| `linux-sandbox/` | Landlock + seccomp隔離 |
| `codex-api/` | HTTP/SSEクライアント（モデルAPI用） |
| `rmcp-client/` | MCPクライアント実装 |
| `utils/` | 13以上のヘルパークレート |

#### 通信パターン：キューベースプロトコル
- **投入フロー**: UI → `codex.submit(Op)` → 非同期チャネル → Sessionが非同期処理
  - Op種別: `UserTurn`, `Interrupt`, `ExecApproval`
- **イベントフロー**: Session → `Event` → `codex.next_event()` → UIがポーリング
  - イベント種別: `TurnStarted`, `AgentMessage`, `ExecCommandBegin`, `TurnComplete`

#### プラグイン・拡張の仕組み

- **MCPクライアント**: 起動時に外部MCPサーバーに接続し、ツール統合が可能
- **MCPサーバー（実験的）**: `codex mcp-server` でCodex自身をMCPサーバーとして公開
- **Agent Skills**: SKILL.mdベースのタスク特化パッケージ
- **AGENTS.md**: リポジトリ内に配置するプロジェクト指示ファイル
- **TypeScript SDK**: `@openai/codex-sdk`でプログラマティック制御

#### 参考ソース
- https://github.com/openai/codex
- https://developers.openai.com/codex/cli/
- https://developers.openai.com/codex/mcp/
- https://developers.openai.com/codex/guides/agents-sdk/
- https://deepwiki.com/openai/codex

---

### 3.2 Claude Code Agent Team機能の仕組み（調査員2: researcher-claude）

#### ツール群の設計

| ツール | 役割 |
|--------|------|
| **TeamCreate** | チームの作成・初期化 |
| **TeamDelete** | チームとタスクディレクトリの削除 |
| **TaskCreate** | タスクの作成 |
| **TaskGet** | タスク詳細の取得 |
| **TaskList** | 全タスク一覧 |
| **TaskUpdate** | ステータス/オーナー/依存関係の更新 |
| **SendMessage** | エージェント間メッセージング |

#### エージェント間通信プロトコル

**メッセージタイプ:**
1. `message` (ダイレクトメッセージ): 特定のチームメイトへの1対1通信
2. `broadcast` (ブロードキャスト): 全チームメイトへの同時送信
3. `shutdown_request` / `shutdown_response`: グレースフルシャットダウンプロトコル
4. `plan_approval_response`: プラン承認/却下

**通信チャネル:**
- stdoutは通信手段ではない。エージェント間の通信はすべてinboxファイル経由
- メッセージは受信者に自動配信される（ポーリング不要）

#### タスク依存関係管理
- `blocks`: このタスクが完了するまで開始できない後続タスク群
- `blockedBy`: このタスクの前提となるタスク群
- 依存タスク完了時に自動アンブロック
- ファイルロックによるレースコンディション防止

#### 実行バックエンド

| バックエンド | 特徴 |
|-------------|------|
| **in-process** | 同一Node.jsプロセス内、最速 |
| **tmux** | 別ターミナルペイン、可視 |
| **iTerm2** | iTerm2のスプリットペイン（macOSのみ） |

#### ファイルベースの状態管理

```
~/.claude/
├── teams/{team-name}/
│   ├── config.json          # チーム構成（メンバー一覧等）
│   └── inboxes/
│       ├── team-lead.json   # リーダーのメールボックス
│       ├── agent-A.json     # メンバーAのメールボックス
│       └── agent-B.json     # メンバーBのメールボックス
└── tasks/{team-name}/
    ├── .lock                # ファイルロック
    ├── 1.json               # タスク#1
    ├── 2.json               # タスク#2
    └── ...
```

#### Hooksシステム
- **TeammateIdleフック**: チームメイトがidle時に自動フォローアップ
- **TaskCompletedフック**: タスク完了時の品質ゲート

#### オーケストレーションパターン
1. 並列スペシャリスト
2. パイプライン
3. スウォーム
4. リサーチ＋実装
5. プラン承認

#### 参考ソース
- https://code.claude.com/docs/en/agent-teams
- https://paddo.dev/blog/claude-code-hidden-swarm/
- https://alexop.dev/posts/from-tasks-to-swarms-agent-teams-in-claude-code/
- https://addyosmani.com/blog/claude-code-agent-teams/

---

### 3.3 既存のマルチエージェントフレームワーク（調査員3: researcher-frameworks）

#### 比較サマリー表

| 項目 | OpenAI Agents SDK | AutoGen | CrewAI | LangGraph | MetaGPT |
|------|-------------------|---------|--------|-----------|---------|
| アーキテクチャ | Handoff/Runner | アクターモデル | ロールベース | グラフベース | SOPベース |
| 通信方式 | Handoff (ツール) | 非同期メッセージ | 共有メモリ+コンテキスト | Supervisor/Swarm | 構造化文書 |
| タスク管理 | 動的Handoff | ルーター/パイプライン | Sequential/Hierarchical | グラフ定義 | SOPフロー |
| Codex統合 | ★★★★★ (公式対応) | ★★☆☆☆ | ★★★☆☆ | ★★★☆☆ | ★★☆☆☆ |
| ライセンス | MIT | MIT | MIT | MIT | MIT |
| 成熟度 | 高（活発） | 移行期 | 高（商用あり） | 高（v1.0） | 中（研究寄り） |
| 学習コスト | 低 | 高 | 中 | 中-高 | 高 |

#### OpenAI Agents SDK（最有力）
- Codex CLIをMCPサーバーとして起動し、Agents SDKから直接制御する公式パターンが存在
- 公式Cookbook: 「Building Consistent Workflows with Codex CLI & Agents SDK」
- Git worktreeを活用した独立したコードベースコピーで並列開発可能
- GitHub: 19,000+ stars, MIT License

#### 参考にすべき設計パターン
- **CrewAI**: ロールベースのエージェント定義とHierarchical Processの設計
- **LangGraph**: Supervisor/Swarmパターンの使い分けと状態永続化
- **AutoGen**: アクターモデルのメッセージパッシングとPub/Subパターン
- **MetaGPT**: SOPベースの構造化出力と中間成果物の品質保証

---

## 4. レビュー結果詳細

### 4.1 技術的実現可能性レビュー（レビュアー1: reviewer-tech）

#### アプローチ別評価

**アプローチA: Agents SDK + MCP — 難易度: 低〜中**
- 公式Cookbookが存在、500-1000行Pythonで実装可能
- `codex()`と`codex-reply()`の2ツールのみでシンプルなAPI
- 懸念: OpenAIモデルロックイン、MCPサーバーメモリ消費大（10並列+17MCPで約30GB）

**アプローチB: Fork — 難易度: 高（非推奨）**
- Rustリライト・App Server移行中で保守コスト極大
- 5,000-15,000行のRustコード追加が必要
- サンドボックスバイパス脆弱性（CVE-2025-59532）への追従責任

**アプローチC: 外部オーケストレーション — 難易度: 中**
- Codex CLI自体の改変不要、1,000-3,000行Node.js
- App ServerのJSON-RPCプロトコルを活用可能
- 懸念: エージェント間通信の欠如、worktree依存関係管理

#### Codex CLIの制約と対策

| 制約 | 対策 |
|------|------|
| MCPサーバーのメモリ消費が大きい | エージェント数を3-5に制限 |
| サンドボックスバイパス脆弱性 | 最新版への追従必須 |
| worktreeで.gitignore対象がコピーされない | シンボリックリンクでnode_modules等を共有 |
| approval-policy="never"が必要 | sandbox設定との組み合わせで制限 |
| MCPサーバーのネスト不可（Issue #6127） | フラットなエージェント構成で対応 |

#### 参考ソース
- https://cookbook.openai.com/examples/codex/codex_mcp_agents_sdk/
- https://developers.openai.com/codex/security/
- https://openai.com/index/unlocking-the-codex-harness/

---

### 4.2 ユーザー体験とAPI設計レビュー（レビュアー2: reviewer-ux）

#### 理想的なUX設計

**ゼロコンフィグ開始（対話型ウィザード）:**
```bash
$ codex team init
? Team name: my-feature-team
? What task should the team work on?
> Add user authentication with OAuth2
? How many agents? (default: 3) 3
? Approval policy: (suggest/auto-approve/manual) suggest

✓ Team "my-feature-team" created with 3 agents
```

**ワンライナー開始（上級者向け）:**
```bash
$ codex team start --config codex-team.toml
$ codex team start --agents 3 --task "Implement REST API"
$ codex team start --template microservice
```

#### リアルタイムダッシュボード

```
╔══════════════════════════════════════════════════════════════╗
║  Team: my-feature-team         Elapsed: 12m 34s             ║
╠══════════════════════════════════════════════════════════════╣
║  Agent          Role       Status       Current Task         ║
║  ─────────────  ─────────  ───────────  ──────────────────── ║
║  ✓ planner     PM         Done         Task breakdown        ║
║  ⟳ frontend    Frontend   Working      Login component       ║
║  ⟳ backend     Backend    Working      OAuth2 endpoints      ║
║                                                              ║
║  Tasks: ████████████░░░░░░░░ 6/10 (60%)                     ║
║                                                              ║
║  Worktrees:                                                  ║
║  ├── main (you are here)                                     ║
║  ├── .worktrees/frontend-login (frontend agent)              ║
║  └── .worktrees/backend-auth (backend agent)                 ║
╚══════════════════════════════════════════════════════════════╝
  [q] quit  [p] pause  [a] approve pending  [l] logs  [d] diff
```

#### CLIコマンド体系

```bash
# チーム管理
codex team init                          # 対話型ウィザードでチーム作成
codex team init --config codex-team.toml # 設定ファイルからチーム作成
codex team init --template <name>        # テンプレートからチーム作成
codex team start                         # チーム実行開始
codex team status                        # チーム状態表示
codex team status --watch                # リアルタイム監視
codex team pause                         # 全エージェント一時停止
codex team resume                        # 全エージェント再開
codex team stop                          # チーム終了
codex team diff                          # 全エージェントの変更差分
codex team merge [agent-name]            # 変更のマージ

# タスク管理
codex task add "Implement login page"    # タスク追加
codex task list                          # タスク一覧
codex task show <task-id>                # タスク詳細
codex task assign <task-id> <agent>      # タスク割当
codex task approve <task-id>             # タスク成果物承認

# エージェント管理
codex agent add --role backend           # エージェント追加
codex agent list                         # エージェント一覧
codex agent restart <name>               # エージェント再起動
codex agent logs <name>                  # エージェントログ
codex agent diff <name>                  # エージェントの変更差分

# テンプレート
codex team templates                     # 利用可能テンプレート一覧
```

#### エラーメッセージ設計

```
✗ Agent "backend" failed on task "Create OAuth2 endpoints"

  Error: API rate limit exceeded (429 Too Many Requests)

  Context:
    File being edited: src/auth/oauth2.ts
    Last successful action: Created file (line 1-45)

  Suggested actions:
    1. Retry:   codex team retry backend
    2. Pause:   codex team pause backend
    3. Replace: codex team restart backend

  Run 'codex team logs backend' for full error trace.
```

#### Claude Codeとの差別化ポイント

| 観点 | Claude Code | Codex Team（提案） |
|------|------------|-------------------|
| **制御モデル** | AI自律型 | ユーザー主導型 |
| **並列開発** | 同一ディレクトリ | git worktreeで完全分離 |
| **設定形式** | なし（全てツール呼び出し） | TOML設定ファイル + AGENTS.md |
| **可視性** | チームリーダーが集約 | CLIダッシュボードで直接監視 |
| **再現性** | 低い（毎回AIが判断） | 高い（設定ファイルで宣言的） |

#### 設計の核となる5原則
1. **ユーザー主導**: ユーザーが常にコントロールを持てる
2. **Progressive Disclosure**: 初心者は3コマンドで開始、上級者は設定ファイルで細かく制御
3. **宣言的再現性**: `codex-team.toml`でチーム構成をgit管理・共有可能
4. **Git-native並列開発**: worktreeベースの完全分離された並列開発
5. **豊かなフィードバック**: エラーは「何が・なぜ・次に何を」を常に提示

#### 参考ソース
- https://clig.dev/
- https://evilmartians.com/chronicles/cli-ux-best-practices-3-patterns-for-improving-progress-displays
- https://devcenter.heroku.com/articles/cli-style-guide

---

## 5. 提案するアーキテクチャ（3案比較）

### 案A: OpenAI Agents SDK + Codex MCPサーバー

**概要**: OpenAI Agents SDK（Python）をオーケストレーションレイヤーとし、各エージェントがCodex CLIのMCPサーバーモードを通じてコード操作を行う。

```
┌─────────────────────────────────────────────┐
│         OpenAI Agents SDK (Python)          │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐    │
│  │ Planner  │ │ Frontend │ │ Backend  │    │
│  │  Agent   │ │  Agent   │ │  Agent   │    │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘    │
│       │Handoff     │            │           │
│  ┌────▼─────────────▼────────────▼─────┐    │
│  │           Runner / Router           │    │
│  └────┬─────────────┬────────────┬─────┘    │
└───────┼─────────────┼────────────┼──────────┘
        │ MCP         │ MCP        │ MCP
   ┌────▼────┐   ┌────▼────┐  ┌───▼─────┐
   │ Codex   │   │ Codex   │  │ Codex   │
   │MCP Srv 1│   │MCP Srv 2│  │MCP Srv 3│
   └─────────┘   └─────────┘  └─────────┘
```

**メリット**: 公式Cookbook存在、500-1000行Python、最速実装
**デメリット**: OpenAIモデルロックイン、メモリ消費大

---

### 案B: Codex CLIフォーク（直接組み込み）

**概要**: Codex CLIのRustソースコードをforkし、codex-coreにTeam/Task/Messagingモジュールを直接組み込む。

```
┌──────────────────────────────────────────┐
│           Codex CLI (Forked Rust)         │
│  ┌────────────────────────────────────┐  │
│  │        codex-team (新規クレート)    │  │
│  │  ┌──────────┐  ┌───────────────┐   │  │
│  │  │TeamMgr   │  │TaskScheduler  │   │  │
│  │  └──────────┘  └───────────────┘   │  │
│  │  ┌──────────┐  ┌───────────────┐   │  │
│  │  │MessageBus│  │AgentRegistry  │   │  │
│  │  └──────────┘  └───────────────┘   │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

**メリット**: 最高パフォーマンス、単一バイナリ
**デメリット**: 保守コスト極大、5,000-15,000行Rust（**非推奨**）

---

### 案C: 外部オーケストレーションレイヤー

**概要**: Node.js/TypeScriptで外部オーケストレータを構築し、`@openai/codex-sdk`経由で複数のCodexプロセスを管理する。

```
┌────────────────────────────────────────────────┐
│     codex-team CLI (Node.js/TypeScript)        │
│  ┌──────────────────────────────────────────┐  │
│  │  Orchestrator                            │  │
│  │  ┌────────────┐  ┌──────────────────┐    │  │
│  │  │TeamManager │  │TaskScheduler     │    │  │
│  │  └────────────┘  └──────────────────┘    │  │
│  │  ┌────────────┐  ┌──────────────────┐    │  │
│  │  │MessageBus  │  │WorktreeManager   │    │  │
│  │  └────────────┘  └──────────────────┘    │  │
│  └─────────┬────────────────┬───────────────┘  │
│            │ JSONL/stdin     │ JSONL/stdin      │
│    ┌───────▼──────┐  ┌──────▼───────┐          │
│    │ codex-sdk    │  │ codex-sdk    │          │
│    │ (Agent 1)    │  │ (Agent 2)    │          │
│    └──────────────┘  └──────────────┘          │
└────────────────────────────────────────────────┘
```

**メリット**: Codex本体変更不要、モデル非依存、段階的拡張可能
**デメリット**: 別パッケージ管理、UX分断の可能性

---

### 3案 比較表

| 評価項目 | 案A: Agents SDK+MCP | 案B: Fork | 案C: 外部オーケストレーション |
|---------|---------------------|-----------|--------------------------|
| **実装難易度** | 低〜中 | 高 | 中 |
| **実装規模** | 500-1000行(Python) | 5000-15000行(Rust) | 1000-3000行(TS) |
| **PoC所要期間** | 1-2週 | 4-8週 | 2-3週 |
| **パフォーマンス** | 中 | 高 | 中 |
| **メモリ消費** | 大（MCP×N） | 小（単一プロセス） | 中（subprocess×N） |
| **UX統合度** | 中 | 高 | 中 |
| **保守コスト** | 低 | 極大 | 中 |
| **モデル依存** | OpenAIロックイン | なし | なし |
| **公式サポート** | Cookbook/ガイドあり | なし | SDK公式 |
| **セキュリティ** | approval=never必須 | 柔軟 | approval設定可能 |

---

## 6. 推奨アプローチとその理由

### 推奨: 案A → 案Cハイブリッド段階的進化

**Phase 1で案Aを採用し、Phase 2以降で案Cの要素を取り込むハイブリッドアプローチ**を推奨する。

**理由**:

1. **最短でのPoC実現**: Agents SDK + MCPの公式Cookbookにより、1-2週間でAgent Teamの動作実証が可能
2. **リスクの最小化**: Codex本体（Rust）への変更を伴わないため、アップストリーム変更の影響を受けない
3. **段階的な成熟**: 各フェーズが独立してリリース可能
4. **将来のCodex本体統合への道筋**: App Server JSON-RPC APIが安定した段階でMCPからJSON-RPCへの移行が可能
5. **案Bの除外理由**: 内部APIが流動的な状態でのフォークは保守コストが極めて高い

---

## 7. 実装ロードマップ

### Phase 1: PoC — Agents SDK + MCPサーバー（1-2週間）

**目標**: 複数のCodexエージェントが協調してタスクを完了するPoCの実現

**マイルストーン**:
- [ ] Agents SDK環境構築、Codex MCPサーバー動作確認
- [ ] Supervisor Agent + Worker Agentsの基本構成実装
- [ ] Handoffパターンによるエージェント間タスク委譲
- [ ] 単純なマルチファイル編集タスクでの動作実証

**成果物**: `codex-team-poc/` Pythonプロジェクト（500-1000行）

---

### Phase 2: Git Worktree並列化（2-3週間）

**目標**: 各エージェントがgit worktreeで分離された環境で並列開発

**マイルストーン**:
- [ ] WorktreeManager実装（worktree作成・削除・マージ）
- [ ] 各Codex MCPサーバーを個別worktreeで起動
- [ ] コンフリクト検出と解決フロー
- [ ] `codex team diff` / `codex team merge` コマンド

**成果物**: worktreeベースの並列開発が動作するプロトタイプ

---

### Phase 3: タスク管理 + CLI UX（2-3週間）

**目標**: 宣言的設定ファイル、タスク依存関係管理、CLIダッシュボードの実装

**マイルストーン**:
- [ ] `codex-team.toml` パーサーとバリデーター
- [ ] ファイルベースのタスク管理（blocks/blockedBy）
- [ ] `codex team init` / `codex team start` / `codex team status` コマンド
- [ ] リアルタイムダッシュボード（`--watch`）
- [ ] テンプレートシステム（fullstack, microservice等）
- [ ] エラーハンドリングとフィードバック

**成果物**: `codex-team` npmパッケージ（Node.js/TypeScript、1000-3000行）

---

### Phase 4: 本格統合（継続的）

**目標**: Codex App Server JSON-RPCへの移行、パフォーマンス最適化

**マイルストーン**:
- [ ] MCP → JSON-RPC API移行（App Server安定後）
- [ ] メモリ使用量最適化（エージェントプール化）
- [ ] CI/CDパイプライン統合
- [ ] Codex Skills統合
- [ ] 公式Codexへの機能提案（RFC/PR）

---

## 8. 具体的なコード例

### 8.1 Phase 1: PoC — Agents SDK + MCPサーバー

```python
#!/usr/bin/env python3
"""
codex_team_poc.py — Codex Agent Team PoC using OpenAI Agents SDK + MCP
"""

import asyncio
import json
from pathlib import Path
from agents import Agent, Runner, function_tool
from agents.mcp import MCPServerStdio


# --- Codex MCPサーバーの設定 ---

def create_codex_mcp_server(working_dir: str, name: str) -> MCPServerStdio:
    """個別のworktreeでCodex MCPサーバーを起動"""
    return MCPServerStdio(
        name=f"codex-{name}",
        params={
            "command": "codex",
            "args": [
                "mcp-server",
                "--approval-policy", "auto-edit",
                "--sandbox", "read-only",
            ],
            "cwd": working_dir,
        },
    )


# --- タスク管理ツール ---

task_store: dict[str, dict] = {}


@function_tool
def create_task(title: str, description: str, assignee: str, depends_on: str = "") -> str:
    """新しいタスクを作成する"""
    task_id = f"task-{len(task_store) + 1}"
    task_store[task_id] = {
        "title": title,
        "description": description,
        "assignee": assignee,
        "depends_on": [d.strip() for d in depends_on.split(",") if d.strip()],
        "status": "pending",
    }
    return json.dumps({"task_id": task_id, "status": "created"})


@function_tool
def complete_task(task_id: str, summary: str) -> str:
    """タスクを完了としてマークする"""
    if task_id in task_store:
        task_store[task_id]["status"] = "completed"
        task_store[task_id]["summary"] = summary
        for tid, task in task_store.items():
            if task_id in task.get("depends_on", []):
                task["depends_on"].remove(task_id)
        return json.dumps({"task_id": task_id, "status": "completed"})
    return json.dumps({"error": f"Task {task_id} not found"})


@function_tool
def list_tasks() -> str:
    """全タスクの状態を返す"""
    return json.dumps(task_store, indent=2, ensure_ascii=False)


# --- エージェント定義 ---

async def main():
    project_dir = Path.cwd()

    # Git worktreeの作成
    worktrees = {}
    for agent_name in ["frontend", "backend"]:
        wt_path = project_dir / ".worktrees" / agent_name
        if not wt_path.exists():
            proc = await asyncio.create_subprocess_exec(
                "git", "worktree", "add", "-b", f"team/{agent_name}",
                str(wt_path), "HEAD",
                cwd=str(project_dir),
            )
            await proc.wait()
        worktrees[agent_name] = str(wt_path)

    # Codex MCPサーバー（各worktreeごと）
    codex_frontend = create_codex_mcp_server(worktrees["frontend"], "frontend")
    codex_backend = create_codex_mcp_server(worktrees["backend"], "backend")

    async with codex_frontend, codex_backend:
        frontend_tools = await codex_frontend.list_tools()
        backend_tools = await codex_backend.list_tools()

        # Plannerエージェント
        planner = Agent(
            name="planner",
            instructions="""あなたはプロジェクトマネージャーです。
ユーザーの要求を分析し、frontendとbackendのタスクに分解してください。
create_taskでタスクを作成し、各エージェントにHandoffしてください。
全タスク完了後、最終レポートを作成してください。""",
            tools=[create_task, complete_task, list_tasks],
            handoffs=["frontend_dev", "backend_dev"],
        )

        # Frontendエージェント
        frontend_dev = Agent(
            name="frontend_dev",
            instructions="""あなたはReact/TypeScriptのフロントエンド開発者です。
Codexツールを使ってフロントエンドのコードを実装してください。
タスク完了後、complete_taskで完了を報告し、plannerにHandoffしてください。""",
            tools=[*frontend_tools, complete_task, list_tasks],
            handoffs=["planner"],
        )

        # Backendエージェント
        backend_dev = Agent(
            name="backend_dev",
            instructions="""あなたはNode.js/TypeScriptのバックエンド開発者です。
Codexツールを使ってバックエンドのコードを実装してください。
タスク完了後、complete_taskで完了を報告し、plannerにHandoffしてください。""",
            tools=[*backend_tools, complete_task, list_tasks],
            handoffs=["planner"],
        )

        # 実行
        result = await Runner.run(
            starting_agent=planner,
            input="ユーザー認証機能（OAuth2）を実装してください。",
        )

        print("=== 実行結果 ===")
        print(result.final_output)
        print("\n=== タスク状態 ===")
        print(json.dumps(task_store, indent=2, ensure_ascii=False))

    # Worktreeの変更を表示
    for name, path in worktrees.items():
        proc = await asyncio.create_subprocess_exec(
            "git", "diff", "--stat", "HEAD",
            cwd=path,
            stdout=asyncio.subprocess.PIPE,
        )
        stdout, _ = await proc.communicate()
        print(f"\n=== {name}の変更 ===")
        print(stdout.decode())


if __name__ == "__main__":
    asyncio.run(main())
```

### 8.2 Phase 3: チーム設定ファイル

```toml
# codex-team.toml — プロジェクトルートに配置

[team]
name = "auth-feature-team"
description = "OAuth2認証機能の実装チーム"
model = "o3-pro"
approval_policy = "suggest"
max_parallel_agents = 4
timeout = "30m"

[team.worktree]
enabled = true
auto_merge = false
branch_prefix = "team/"

[[agents]]
name = "planner"
role = "project-manager"
instructions = """
タスクを分析し、実装計画を作成してください。
各タスクには明確な完了条件を設定してください。
"""

[[agents]]
name = "frontend"
role = "frontend-developer"
profile = "./agents/frontend.md"
skills = ["react", "typescript", "css"]
worktree_path = "frontend-work"

[[agents]]
name = "backend"
role = "backend-developer"
profile = "./agents/backend.md"
skills = ["nodejs", "database", "api-design"]
worktree_path = "backend-work"

[[agents]]
name = "tester"
role = "qa-engineer"
depends_on = ["frontend", "backend"]

[[tasks]]
title = "設計レビューと計画作成"
assignee = "planner"
priority = "high"

[[tasks]]
title = "ログインコンポーネントの実装"
assignee = "frontend"
depends_on = ["設計レビューと計画作成"]

[[tasks]]
title = "OAuth2 APIエンドポイントの実装"
assignee = "backend"
depends_on = ["設計レビューと計画作成"]

[[tasks]]
title = "E2Eテストの作成と実行"
assignee = "tester"
depends_on = ["ログインコンポーネントの実装", "OAuth2 APIエンドポイントの実装"]
```

---

## 9. リスクと対策

### 9.1 技術的リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| MCPサーバーのメモリ消費（10並列+17MCPで約30GB） | 高 | エージェント数上限設定（デフォルト4）、プール化 |
| サンドボックスバイパス脆弱性（CVE-2025-59532） | 高 | 最新パッチ適用、worktreeでの権限分離 |
| MCPサーバーのネスト不可（Issue #6127） | 中 | フラットなMCPサーバー構成を採用 |
| approval-policy=never必須 | 中 | 差分レビューUI実装、worktreeで変更隔離 |
| Codex App Server移行による破壊的変更 | 中 | MCPプロトコル経由で影響限定 |

### 9.2 プロダクトリスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| OpenAIモデルロックイン | 中 | Phase 3でNode.jsオーケストレーターに移行 |
| コスト増大（複数エージェント×LLM API） | 高 | `--explain`でコスト概算表示、`--budget`オプション |
| UX分断（別パッケージ） | 中 | `codex team`サブコマンドとして統合 |
| エージェント間コンフリクト | 中 | git worktree分離、AI支援マージ |

### 9.3 セキュリティリスク

| リスク | 対策 |
|--------|------|
| 意図しないファイル操作 | worktreeでの作業範囲限定、File Scope設定 |
| MCP経由の特権昇格 | サンドボックス厳格化 |
| 機密ファイルの漏洩 | `.codexignore`による除外設定 |

---

## 10. 結論

Codex CLIにAgent Team機能を追加することは技術的に実現可能であり、Claude Code Agent Teamsに対して**ユーザー主導の宣言的制御**、**git worktreeベースの並列開発**、**TOML設定ファイルによる再現性**という明確な差別化要素を持つ実装が可能である。

推奨する**Agents SDK + MCPを起点としたハイブリッド段階的アプローチ**により:

1. **Phase 1（1-2週間）**: Agents SDK + MCPサーバーで最速のPoC
2. **Phase 2（2-3週間）**: git worktreeによる並列開発環境
3. **Phase 3（2-3週間）**: `codex team`サブコマンド、TOML設定、CLIダッシュボード
4. **Phase 4（継続的）**: App Server JSON-RPC移行、公式Codexへの機能提案

**次のステップとして、Phase 1のPoCプロジェクトの着手を推奨する。**

---

*本提案書はcodex-team-researchチーム（調査員3名・レビュアー2名）の調査・レビュー結果を統合して作成されました。*
