" lsp support
if has('nvim')
    " goto references
    nnoremap <buffer> ma :call LanguageClient_textDocument_references()<CR>
    " document symbols
    nnoremap <buffer> md :call LanguageClient_textDocument_documentSymbol()<CR>
    " rename
    nnoremap <buffer> mn :call LanguageClient_textDocument_rename()<CR>
    " workspace symbols
    nnoremap <buffer> mv :call LanguageClient_workspace_symbol()<CR>
    " jump
    nnoremap <buffer> J :call LanguageClient_textDocument_definition()<CR>
    " information
    nnoremap <buffer> K :call LanguageClient_textDocument_hover()<CR>
else
    " goto references
    nnoremap <buffer> ma :LspReferences<CR>
    " document symbols
    nnoremap <buffer> md :LspDocumentSymbol<CR>
    " rename
    nnoremap <buffer> mn :LspRename<CR>
    " workspace symbols
    nnoremap <buffer> mv :LspWorkspaceSymbol<CR>
    " jump
    nnoremap <buffer> J :LspDefinition<CR>
    " information
    nnoremap <buffer> K :LspHover<CR>
end

" make
nnoremap <buffer> mm :AsyncRun make<CR>:copen<CR>
" build
nnoremap <buffer> mb :AsyncRun make -C build<CR>:copen<CR>
" cmake
nnoremap <buffer> mx :AsyncRun cd build && cmake ..<CR>:copen<CR>
nnoremap <buffer> mz :AsyncRun cmake .<CR>:copen<CR>

" Single file C compilation with different flags
" simple
nnoremap <buffer> mcs :let @m = "g++ -O3 -Wall -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" intel compiler
nnoremap <buffer> mcis :let @m = "ic++ -fast -O3 -Wall -g " . expand('%:t') . " -o " . expand('%:t:r') . ".in" <bar> TxSend(@m)<CR>
" with math support
nnoremap <buffer> mcS :let @m = "g++ -O3 -Wall -lcblas -llapack -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" intel compiler with openmp
nnoremap <buffer> mcio :let @m = "ic++ -fast -O3 -Wall -fopenmp -g " . expand('%:t') . " -o " . expand('%:t:r') . ".in" <bar> TxSend(@m)<CR>
" openmp without math
nnoremap <buffer> mco :let @m = "g++ -O3 -Wall -fopenmp -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" openmp with math
nnoremap <buffer> mcO :let @m = "g++ -O3 -Wall -lcblas -llapack -fopenmp -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" cuda math
nnoremap <buffer> mccm :let @m = "nvc++ -O3 -Wall -lcblas -llapack -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" cuda simple
nnoremap <buffer> mccs :let @m = "nvc++ -O3 -Wall -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" cuda openmp
nnoremap <buffer> mcco :let @m = "nvc++ -O3 -Wall -fopenmp -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" mpi math
nnoremap <buffer> mcim :let @m = "mpic++ -O3 -Wall -lcblas -llapack -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" mpi simple
nnoremap <buffer> mcis :let @m = "mpic++ -O3 -Wall -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" hybrid
nnoremap <buffer> mchm :let @m = "mpic++ -O3 -Wall -lcblas -llapack -fopenmp -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" hybrid simple
nnoremap <buffer> mchs :let @m = "mpic++ -O3 -Wall -fopenmp -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" armadillo simple
nnoremap <buffer> mcas :let @m = "g++ -O3 -Wall -larmadillo -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" armadillo math
nnoremap <buffer> mcam :let @m = "g++ -O3 -Wall -lcblas -llapack -larmadillo -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" armadillo intel
nnoremap <buffer> mcai :let @m = "ic++ -O3 -Wall -larmadillo -g " . expand('%:t') . " -o " . expand('%:t:r') . ".out" <bar> TxSend(@m)<CR>
" run g++ compiled binary
nnoremap <buffer> mr :let @m = "./" . expand('%:t:r') . ".out " <bar> TxSend(@m)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" run ic++ compiled binary
nnoremap <buffer> mi let @m = "./" . expand('%:t:r') . ".in " <bar> TxSend(@m)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" run mpi compiled binary
nnoremap <buffer> me :let @m = "mpiexec ./" . expand('%:t:r') . ".out " <bar> TxSend(@m)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" debugging
" call lldb
nnoremap <buffer> mgg :let @m = "lldb"<CR>:TxSend(@m)<CR>
" create target
nnoremap <buffer> mge :let @m = "target create "<bar>TxSend(@m)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" set breakpoint in current line
nnoremap <buffer> mgs :call SetBreakpoint()<CR>:LCD<CR>:let @m = "breakpoint set --file " . expand('%') . " --line " . line('.')<CR>:TxSend(@m)<CR>:Rooter<CR>
" unset breakpoint in current line
nnoremap <buffer> mgx :call UnsetBreakpoint()<CR>:let @m = "breakpoint list"<CR>:TxSend(@m)<CR>:let @m = "breakpoint delete "<bar>TxSend(@m)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" set breakpoint in current function
nnoremap <buffer> mgf :call SetBreakpoint()<CR>:let @m = "breakpoint set --name " line('<cword>')<CR>:TxSend(@m)<CR>
" set breakpoint in current class method
nnoremap <buffer> mgm :call SetBreakpoint()<CR>:let @m = "breakpoint set --method " . expand('%') . ":" . line('<cword>')<CR>:TxSend(@m)<CR>
" clear all breakpoints
nnoremap <buffer> mga :call RemoveAllBreakpoints()<CR>:let @m = "breakpoint delete"<CR>:TxSend(@m)<CR>:let @m = "Y"<CR>:TxSend(@m)<CR>
" next line
nnoremap <buffer> mgn :let @m = "n"<CR>:TxSend(@m)<CR>
" continue
nnoremap <buffer> mgc :let @m = "c"<CR>:TxSend(@m)<CR>
" run
nnoremap <buffer> mgr :let @m = "r"<CR>:TxSend(@m)<CR>
" list all breakpoints
nnoremap <buffer> mgl :let @m = "breakpoint list"<CR>:TxSend(@m)<CR>
" step in
nnoremap <buffer> mgi :let @m = "s"<CR>:TxSend(@m)<CR>
" go one level up
nnoremap <buffer> mgk :let @m = "up"<CR>:TxSend(@m)<CR>
" print value of variable
nnoremap <buffer> mgp :let @m = "p " . expand('<cWORD>')<CR>:TxSend(@m)<CR>
" print value of the pointer variable
nnoremap <buffer> mgo :let @m = "p * " . expand('<cWORD>')<CR>:TxSend(@m)<CR>
" quit debugger
nnoremap <buffer> mgq :call RemoveAllBreakpoints()<CR>:let @m = "q"<CR>:TxSend(@m)<CR>

" get all the signs for breakpoints in vim {{{2
nnoremap <buffer> mgv :sign list mybreakpoint<CR>
