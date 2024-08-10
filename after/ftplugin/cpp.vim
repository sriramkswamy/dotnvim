" error checking using cppcheck
setlocal makeprg=gmake
setlocal errorformat=%m,[%f:%l]:%m

" add header paths
setlocal path+=/usr/include/**
setlocal path+=/usr/include/boost/**

" add more completion sources
" setlocal complete+=i
setlocal complete+=t
