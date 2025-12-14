nnoremap <silent> <leader>gi :let @s = line('.') . ",+1:" . expand('%')<cr>:<C-U>Git! log -100 -L <C-R>s<cr>

vnoremap <silent> <leader>gi <Esc>:let @s = getpos("'\<")[1] . "," . getpos("'\>")[1]<cr>:<C-U>Git! log -100 -L <C-R>s:%<CR>

