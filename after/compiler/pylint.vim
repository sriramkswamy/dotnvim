let current_compiler = 'pylint'
CompilerSet makeprg=pylint\ --reports=n\ --output-format=parseable
CompilerSet errorformat=%f:%l:\ %m
