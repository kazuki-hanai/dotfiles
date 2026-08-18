# Global Instructions

## Shell Environment (mise)

This machine manages runtimes and CLI tools with [mise](https://mise.jdx.dev).
Interactive shells auto-activate it via `~/.dotfiles/shell/env.sh`, but the
non-interactive shells agents use do **not** read `~/.zshrc`, so mise is
inactive by default and tools may resolve to stale versions (e.g. old asdf
shims).

Before running shell commands, activate mise so you use the same tool versions
as the user:

```bash
source ~/.dotfiles/shell/env.sh
```

Do this at the start of a shell (or prefix commands with it) whenever you need
project runtimes/tools such as `node`, `go`, `deno`, `tokei`, etc. Verify with
`mise doctor` (expect `activated: yes`). To run a single command with the right
versions without activating, use `mise exec -- <cmd>`.

## Session Handover

At the start of every session, check if a `.handovers/` directory exists in the project root. If it does:

1. Find the most recent `.md` file in `.handovers/` (sorted by filename timestamp).
2. Read it and acknowledge the handover context.
3. Pay special attention to the **Rejected Approaches** section to avoid re-exploring dead ends.
4. Use the **Next Session Priorities** section to guide your initial focus.

If no `.handovers/` directory exists, proceed normally.

## Creating Handovers

Use the `/handover` command at the end of a session to generate a structured handover document. This preserves context for the next session and works across both Claude Code and Codex.
