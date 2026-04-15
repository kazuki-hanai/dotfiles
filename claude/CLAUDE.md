# Global Instructions

## Session Handover

At the start of every session, check if a `.handovers/` directory exists in the project root. If it does:

1. Find the most recent `.md` file in `.handovers/` (sorted by filename timestamp).
2. Read it and acknowledge the handover context.
3. Pay special attention to the **Rejected Approaches** section to avoid re-exploring dead ends.
4. Use the **Next Session Priorities** section to guide your initial focus.

If no `.handovers/` directory exists, proceed normally.

## Creating Handovers

Use the `/handover` command at the end of a session to generate a structured handover document. This preserves context for the next session and works across both Claude Code and Codex.
