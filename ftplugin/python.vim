" outline
" nnoremap <buffer> <space>a :lvimgrep /^\s*\(class\\|def\\|properties\\|classdef\).*/ %<CR>:lopen<CR>

" run the current file
nnoremap <buffer> mm :OverseerShell python3 %<Space>

" debugging
" set break point
nnoremap <buffer> mgs :normal! Oimport ipdb; ipdb.set_trace()<CR>j
" unset break point
nnoremap <buffer> mgu :normal! kdd<CR>
" next line
nnoremap <buffer> mgn :let @m = "n"<CR>:call TxSend(@m)<CR>
" step in
nnoremap <buffer> mgi :let @m = "s"<CR>:call TxSend(@m)<CR>
" continue
nnoremap <buffer> mgc :let @m = "c"<CR>:call TxSend(@m)<CR>
" run till end of subroutine
nnoremap <buffer> mgr :let @m = "r"<CR>:call TxSend(@m)<CR>
" print the value
nnoremap <buffer> mgv :let @m = "p " . expand('<cword>')<CR>:call TxSend(@m)<CR>
" which class am i in
nnoremap <buffer> mgw :let @m = "p self"<CR>:call TxSend(@m)<CR>
" list where i am
nnoremap <buffer> mgl :let @m = "l"<CR>:call TxSend(@m)<CR>
" quit debugging
nnoremap <buffer> mgq :let @m = "q"<CR>:call TxSend(@m)<CR>

" clear the variables
nnoremap <buffer> mu :let @m = "%reset -f"<CR>:call TxSend(@m)<CR>
" exit python
nnoremap <buffer> mq :let @m = "exit()"<CR>:call TxSend(@m)<CR>

" metadata
" sort the imports
nnoremap <buffer> mi :sort i /\w\+/<CR>
vnoremap <buffer> mi :sort i /\w\+/<CR>
" get the shape of the matrix/object
nnoremap <buffer> mz :let @m = expand('<cword>') . ".shape"<CR>:call TxSend(@m)<CR>
" dimensions of the variable at point
nnoremap <buffer> mX :let @m = expand('<cword>') . ".ndim"<CR>:call TxSend(@m)<CR>
" get the size of object
nnoremap <buffer> mx :let @m = expand('<cword>') . ".size"<CR>:call TxSend(@m)<CR>
" get the length of the object
nnoremap <buffer> ml :let @m = "len(" . expand('<cword>') . ")"<CR>:call TxSend(@m)<CR>
" get the type of the object
nnoremap <buffer> mw :let @m = "type(" . expand('<cword>') . ")"<CR>:call TxSend(@m)<CR>
" get the type of the object
vnoremap <buffer> mw "my:let @m = "type(<C-R>m)"<CR>:call TxSend(@m)<CR>
" get the type of the object (from space to space)
nnoremap <buffer> mW :let @m = "type(" . expand('<cWORD>') . ")"<CR>:call TxSend(@m)<CR>
" get the sum of the matrix/object
nnoremap <buffer> m= :let @m = expand('<cword>') . ".sum()"<CR>:call TxSend(@m)<CR>
" get the cumulative sum of the matrix/object
nnoremap <buffer> m+ :let @m = expand('<cword>') . ".cumsum()"<CR>:call TxSend(@m)<CR>
" get the mean of the matrix/object
nnoremap <buffer> me :let @m = expand('<cword>') . ".mean()"<CR>:call TxSend(@m)<CR>
" list all in interactive workspace
nnoremap <buffer> maa :let @m = "whos"<CR>:call TxSend(@m)<CR>
" list all locals
nnoremap <buffer> mal :let @m = "locals()"<CR>:call TxSend(@m)<CR>
" list all in scope
nnoremap <buffer> mag :let @m = "globals()"<CR>:call TxSend(@m)<CR>
" list all globals
nnoremap <buffer> mas :let @m = "dir()"<CR>:call TxSend(@m)<CR>

" Error checking
nnoremap <buffer> mf :OverseerShell pylint\ --reports=n\ --output-format=parseable %<CR>
