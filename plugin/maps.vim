nnoremap <silent> vu :Git blame<cr>
nnoremap <silent> yu :let @s = line('.') . ",+1:" . expand('%')<cr>:<C-U>Git! log -100 -L <C-R>s<cr>
nnoremap <silent> yU :Git! log -100 -- %<cr>
nnoremap <silent> <leader><cr> :StartJob gitk<cr>
nnoremap <silent> <leader>e :tabe<CR>:terminal tig<cr>

vnoremap <silent> vu :Git blame<cr>
vnoremap <silent> yu <Esc>:let @s = getpos("'\<")[1] . "," . getpos("'\>")[1]<cr>:<C-U>Git! log -100 -L <C-R>s:%<CR>
vnoremap <silent> yU <Esc>:let @s = getpos("'\<")[1] . "," . getpos("'\>")[1]<cr>:<C-U>Git! log -100 -L <C-R>s:%<CR>
vnoremap <silent> <leader><cr> :StartJob gitk<cr>
vnoremap <silent> <leader>e :terminal tig<cr>

