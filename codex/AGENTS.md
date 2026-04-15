# Global Instructions for Codex

## Session Handover

At the start of every session, check if a `.handovers/` directory exists in the project root. If it does:

1. Find the most recent `.md` file in `.handovers/` (sorted by filename timestamp).
2. Read it and acknowledge the handover context.
3. Pay special attention to the **Rejected Approaches** section to avoid re-exploring dead ends.
4. Use the **Next Session Priorities** section to guide your initial focus.

If no `.handovers/` directory exists, proceed normally.

## Creating Handovers

To generate a handover document at the end of a session, use the `handover` skill or follow the template below. Save the output to `.handovers/YYYY-MM-DD_HHmm.md` in the project root.

### Handover Template

```markdown
---
tool: codex
date: "YYYY-MM-DDTHH:mm:ss"
session_id: "<session-id-if-available>"
---

# Session Handover

## Session Summary
<!-- One-paragraph overview of what this session was about -->

## Work Done
<!-- Bulleted list of completed tasks and changes -->

## Decisions Made
<!-- Key technical decisions and their rationale -->

## Rejected Approaches
<!-- Approaches that were considered but abandoned, and WHY they were rejected.
     This is critical — it prevents the next session from re-exploring dead ends. -->

## Files Modified
<!-- List of files that were created, modified, or deleted -->

## Current State
<!-- What state is the project in right now? Does it build? Are tests passing? -->

## Unresolved Issues
<!-- Known bugs, edge cases, or problems that remain -->

## Next Session Priorities
<!-- What should the next session focus on first? -->

## Technical Notes
<!-- Any gotchas, workarounds, or non-obvious details the next session should know -->
```

### Important

- Be thorough in the "Rejected Approaches" section — this saves the most time for the next session.
- Include specific file paths, line numbers, and error messages where relevant.
- The handover should be self-contained: a new session should understand the full context without needing to re-explore.
