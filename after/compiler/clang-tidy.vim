let current_compiler = 'clang-tidy'
CompilerSet makeprg=clang-tidy
CompilerSet errorformat = '%E%f:%l:%c: fatal error: %m,' .
        \ '%E%f:%l:%c: error: %m,' .
        \ '%W%f:%l:%c: warning: %m,' .
        \ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
        \ '%E%m'
