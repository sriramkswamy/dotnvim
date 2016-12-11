" rtags
" jump to parent
nnoremap <buffer> <Space>mp :call rtags#JumpToParent()<CR>
" find reference
nnoremap <buffer> <Space>mr :call rtags#FindRefsOfWordUnderCursor()<CR>
" find symbol
nnoremap <buffer> <Space>my :call rtags#FindSymbolsOfWordUnderCursor()<CR>
" find virtuals
nnoremap <buffer> <Space>mv :call rtags#FindVirtuals()<CR>
" reindex file
nnoremap <buffer> <Space>mx :call rtags#ReindexFile()<CR>
" rename symbol
nnoremap <buffer> <Space>mn :call rtags#RenameSymbolUnderCursor()<CR>
" list projects
nnoremap <buffer> <Space>ml :call rtags#ProjectList()<CR>
" jump
nnoremap <buffer> J :call rtags#JumpTo(g:SAME_WINDOW)<CR>
" information
nnoremap <buffer> K :call rtags#SymbolInfo()<CR>

" Single file C++ compilation with different flags
" simple
nnoremap <buffer> <Space>ms :Dispatch! cd %:p:h <bar> g++ -std=c++11 -Wall -g -o %:p:r.out %<CR>
" with math support
nnoremap <buffer> <Space>mm :Dispatch! cd %:p:h <bar> g++ -std=c++11 -Wall -lgsl -lcblas -llapack -O2 -g -o %:p:r.out %<CR>
" openmp
nnoremap <buffer> <Space>mo :Dispatch! cd %:p:h <bar> g++ -std=c++11 -Wall -lgsl -lcblas -llapack -fopenmp -O2 -g -o %:p:r.out %<CR>
" mpi
nnoremap <buffer> <Space>mi :Dispatch! cd %:p:h <bar> /usr/local/openmpi/bin/mpic++ -std=c++11 -Wall -lgsl -lcblas -llapack -O2 -g -o %:p:r.out %<CR>
" hybrid
nnoremap <buffer> <Space>mh :Dispatch! cd %:p:h <bar> /usr/local/openmpi/bin/mpic++ -std=c++11 -Wall -lgsl -lcblas -llapack -fopenmp -O2 -g -o %:p:r.out %<CR>
" armadillo
nnoremap <buffer> <Space>ma :Dispatch! cd %:p:h <bar> g++ -std=c++11 -Wall -lgsl -lcblas -llapack -larmadillo -O2 -g -o %:p:r.out %<CR>