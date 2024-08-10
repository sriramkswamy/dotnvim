command! CD cd %:p:h
command! LCD lcd %:p:h
command! WCD :windo cd %:p:h<CR>
command! TCD :tabdo cd %:p:h<CR>
