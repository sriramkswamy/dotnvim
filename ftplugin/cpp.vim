" outline
" nnoremap <buffer> <space>a :lvimgrep /^\s*\(class\\|namespace\\|struct\\|#\s*ifndef\\|#\s*include\\|#\s*define\\|\w+\s\w*\(.*\)\\|^\s*\w\+\s\+\w\+(.*)\n{\\|^\s*\w\+\s\+\w\+(.*)\s{$\\|^\s*\w\+\s\+\w\+(.*);$\).*/ %<CR>:lopen<CR>

" run the current file
nnoremap <buffer> mms :let @m = "g++ -O3 -Wall -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out"<CR>:call TxSend(@m)<CR>
nnoremap <buffer> mmo :let @m = "./" . expand('%:t:r') . ".out "<CR>:call TxSend(@m)<CR>

" run typical run file
nnoremap <buffer> mmm :OverseerShell ./run.csh<CR>
nnoremap <buffer> mmw :OverseerShell ./run.sh<CR>

" debugging
" call gdb
nnoremap <buffer> mgd :let @m = "frame"<CR>:call TxSend(@m)<CR>
" catch throw at exceptions
nnoremap <buffer> mge :let @m = "catch throw"<CR>:call TxSend(@m)<CR>
" backtrace
nnoremap <buffer> mgb :let @m = "backtrace"<CR>:call TxSend(@m)<CR>
nnoremap <buffer> mgB :let @m = "backtrace full"<CR>:call TxSend(@m)<CR>
" set breakpoint in current line
nnoremap <buffer> mgs :let @m = "break " . expand('%') . ":" . line('.')<CR>:call TxSend(@m)<CR>
" set breakpoint with condition
nnoremap <buffer> mgg :let @g = ""<Left>
nnoremap <buffer> mgf :let @m = "break " . expand('%') . ":" . line('.') . " if " . expand(@g)<CR>:call TxSend(@m)<CR>
" unset breakpoint in current line
nnoremap <buffer> mgx :let @m = "info b"<CR>:let @m = "delete " . expand('%') . ":" . line('.')<CR>:call TxSend(@m)<CR>
" clear all breakpoints
nnoremap <buffer> mga :let @m = "clear"<CR>:call TxSend(@m)<CR>
" finish
nnoremap <buffer> mgm :let @m = "finish"<CR>:call TxSend(@m)<CR>
" next line
nnoremap <buffer> mgn :let @m = "next"<CR>:call TxSend(@m)<CR>
" continue
nnoremap <buffer> mgc :let @m = "continue"<CR>:call TxSend(@m)<CR>
" run
nnoremap <buffer> mgr :let @m = "run"<CR>:call TxSend(@m)<CR>
" list all breakpoints
nnoremap <buffer> mgl :let @m = "info b"<CR>:call TxSend(@m)<CR>
" step in
nnoremap <buffer> mgi :let @m = "step"<CR>:call TxSend(@m)<CR>
" kill
nnoremap <buffer> mgk :let @m = "kill"<CR>:call TxSend(@m)<CR>
" print value of variable
nnoremap <buffer> mgp :let @m = "print " . expand('<cword>')<CR>:call TxSend(@m)<CR>
vnoremap <buffer> mgp "1y:let @m = "print " . expand(@1)<CR>:call TxSend(@m)<CR>
" print type of variable
nnoremap <buffer> mgt :let @m = "ptype " . expand('<cword>')<CR>:call TxSend(@m)<CR>
vnoremap <buffer> mgt "1y:let @m = "ptype " . expand(@1)<CR>:call TxSend(@m)<CR>
" print value of address
nnoremap <buffer> mgA :let @m = "print &" . expand('<cword>')<CR>:call TxSend(@m)<CR>
vnoremap <buffer> mgA "1y:let @m = "print &" . expand(@1)<CR>:call TxSend(@m)<CR>
" print value of pointer
nnoremap <buffer> mgP :let @m = "print *" . expand('<cword>')<CR>:call TxSend(@m)<CR>
vnoremap <buffer> mgP "1y:let @m = "print *" . expand(@1)<CR>:call TxSend(@m)<CR>
" watch variable
nnoremap <buffer> mgw :let @m = "watch " . expand('<cword>')<CR>:call TxSend(@m)<CR>
vnoremap <buffer> mgw "1y:let @m = "watch " . expand(@1)<CR>:call TxSend(@m)<CR>
" watch pointer
nnoremap <buffer> mgW :let @m = "watch *" . expand('<cword>')<CR>:call TxSend(@m)<CR>
vnoremap <buffer> mgW "1y:let @m = "watch *" . expand(@1)<CR>:call TxSend(@m)<CR>
" send yes or no
nnoremap <buffer> mgy :let @m = "y"<CR>:call TxSend(@m)<CR>
nnoremap <buffer> mgY :let @m = "n"<CR>:call TxSend(@m)<CR>

" print value of the pointer variable
nnoremap <buffer> mgo :let @m = "p *" . expand('<cword>')<CR>:call TxSend(@m)<CR>
" quit debugger
nnoremap <buffer> mgq :let @m = "q"<CR>:call TxSend(@m)<CR>

" error checking
nnoremap <buffer> mf :OverseerShell gmake<Space>
