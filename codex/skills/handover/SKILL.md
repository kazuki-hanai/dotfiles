---
name: handover
description: Generate a structured session handover document for the current repository. Use when the user asks to hand over, create a handover, or save session context for the next Codex session.
---

# Handover Skill

Generate a structured session handover document.

## Trigger

When the user asks to "hand over", "create a handover", or "save session context".

## Behavior

1. Create the `.handovers/` directory in the project root if it doesn't exist.
2. Review the entire session context.
3. Generate a handover file at `.handovers/YYYY-MM-DD_HHmm.md` using the current timestamp.
4. Use the template defined in AGENTS.md with `tool: codex` in the YAML frontmatter.
5. Be thorough in the **Rejected Approaches** section — this is the highest-value section for cross-session efficiency.
6. The handover should be self-contained: a new session should understand the full context without needing to re-explore.
