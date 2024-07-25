### New notes

> OpenNotes Input in cmd

### Select and replace

> %is always filePath is vim including configs for the plugin
> highlight and use keys :s/replaceThis/new
> **global is**
> :%s/replaceThis/new this will only do the first occurence
> :%s/old/new/g: Replace all occurrences of 'old' with 'new' in the file.
> :%s/old/new/gc: Replace all occurrences with confirmation.

### quick fix list

### Vblock for multy cursor

> simple go Vblock mode and then shift + a/i

### mini.surround

> keymaps:
> prefix: gs
> gsa Add Surrounding n, v + "whatever you want to surround it with"
> gsd Delete Surrounding n + whatever you want to delete it with
> gsf Find Right Surrounding n
> gsF Find Left Surrounding n
> gsh Highlight Surrounding n
> gsn Update MiniSurround.config.n_lines n
> gsr Replace Surrounding n

##### shadow window layout

Ctrl+w + H or K

> H-> | | K -> =
can set the staus bar on tmux with tmux with tmux line set g satus on tmux.conf
set status


diW 
will delete till whitespace

Q will replay macros the ones use just did



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
### Definition

> edit = '<C-c>o'
> vsplit = '<C-c>v'
> split = '<C-c>i'


