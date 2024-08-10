" Syntax checking
setlocal errorformat=%f:%l:\ %m
setlocal makeprg=pylint\ --reports=n\ --output-format=parseable

" add extra paths
setlocal path+=**/*.py

" add more completion sources
" setlocal complete+=i
setlocal complete+=t

