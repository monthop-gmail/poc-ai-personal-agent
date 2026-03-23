Manage personal notes in the ~/notes/ directory.

If $ARGUMENTS is empty, list all existing notes.

Otherwise, interpret the arguments:
- If it starts with "add" or "new" — create a new note with the given content. Use a descriptive filename based on the content. Add a timestamp header.
- If it starts with "find" or "search" — search through existing notes for the keyword
- If it starts with "read" — display the specified note
- If it starts with "delete" — confirm with the user, then delete the note

Notes format:
```
# [Title]
Date: YYYY-MM-DD HH:MM
---
[Content]
```
