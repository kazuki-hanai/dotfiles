Review the current session and generate a structured handover document for the next session.

## Instructions

1. Create the `.handovers/` directory in the project root if it doesn't exist.
2. Generate a handover file at `.handovers/YYYY-MM-DD_HHmm.md` using the current timestamp.
3. Review the entire session context and fill in each section below thoroughly.

## Handover Template

```markdown
---
tool: claude-code
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

## Important

- Be thorough in the "Rejected Approaches" section — this saves the most time for the next session.
- Include specific file paths, line numbers, and error messages where relevant.
- The handover should be self-contained: a new session should understand the full context without needing to re-explore.
