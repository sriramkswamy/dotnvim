" some settings for markdown files
setlocal wrap
setlocal spell

" Ultisnips add tex snippets
UltiSnipsAddFiletypes markdown.tex

" pandoc
" convert to html
nnoremap <buffer> mh :AsyncRun pandoc % -s --mathjax -o %:r.html<CR>
" convert to pdf with toc
nnoremap <buffer> mm :AsyncRun pandoc -V geometry:margin=1in % -o %:r.pdf<CR>
" convert to latex with toc
nnoremap <buffer> mt :AsyncRun pandoc -V geometry:margin=1in % -o %:r.tex<CR>
" convert to rst with toc
nnoremap <buffer> me :AsyncRun pandoc % -o %:r.rst<CR>
" convert to org with toc
nnoremap <buffer> mg :AsyncRun pandoc % -o %:r.org<CR>
" open resulting document
nnoremap <buffer> mf :!open -a %<CR>
