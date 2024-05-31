### Definition

> edit = '<C-c>o'
> vsplit = '<C-c>v'
> split = '<C-c>i'
> tabe = '<C-c>t'
> quit = 'q'
> close = '<C-c>k'

### Lspsage keyMaps

> These are default keymaps in finder.keys table section:
>
> shuttle = '[w' shuttle bettween the finder layout window
> toggle_or_open = 'o' toggle expand or open
> vsplit = 's' open in vsplit
> split = 'i' open in split
> tabe = 't' open in tabe
> tabnew = 'r' open in new tab
> quit = 'q' quit the finder, only works in layout left window
> close = '<C-c>k' close finde

### Calls hierarychy

> Default keymaps in callhierarchy.keys:
>
> edit = 'e' edit (open) file
> vsplit = 's' vsplit
> split = 'i' split
> tabe = 't' open in new tab
> quit = 'q' quit layout
> shuttle = '[w' shuttle bettween the layout left and right
> toggle_or_req = 'u' toggle or do request
> close = '<C-c>k' close layout

### Outline

> Default keymaps in outline.keys section:
>
> toggle_or_jump = 'o' toggle or jump
> quit = 'q' quit outline window
> jump = 'e' jump to pos even on a expand/collapse node

#### Lspsaga project-wide Replace

:Lspsaga project_replace old_name new_name.
