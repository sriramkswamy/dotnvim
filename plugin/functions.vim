" vim:set et sts=0 sw=4 ts=4 tw=80 foldmethod=marker:

command! -nargs=1 StartJob
         \ call jobstart(<f-args>, {
         \    'on_exit': { j,d,e ->
         \       execute('echom "command finished with exit status '.d.'"', '')
         \    }
         \ })

" create an operator to send things to tmux {{{1
map ms <Plug>(operator-tmux-send)
function! TxSend(pat)
    execute 'TmuxSend ' . a:pat
endfunction
call operator#user#define('tmux-send', 'OperatorTmuxSend')
function! OperatorTmuxSend(motion_wise)
	let v = operator#user#visual_command_from_wise_name(a:motion_wise)
	execute 'normal!' '`[' . v . '`]"my'
    call TxSend(@m)
endfunction

" create an operator to search within file {{{1
function! FindWordLocal(pat)
    execute 'lvimgrep /\<' . a:pat . '\>/ %'
endfunction
map gw <Plug>(operator-lvim-grep)
call operator#user#define('lvim-grep', 'OperatorLvimGrep')
function! OperatorLvimGrep(motion_wise)
	let v = operator#user#visual_command_from_wise_name(a:motion_wise)
	execute 'normal!' '`[' . v . '`]"ny'
	call FindWordLocal(@n)
endfunction

" create an operator to search within project {{{1
function! GrepInProject(pat)
    execute 'grep! --vimgrep ' . a:pat
endfunction
map gs <Plug>(operator-grep)
call operator#user#define('grep', 'OperatorGrep')
function! OperatorGrep(motion_wise)
	let v = operator#user#visual_command_from_wise_name(a:motion_wise)
	execute 'normal!' '`[' . v . '`]"ny'
	call GrepInProject(@n)
endfunction
map gss :grep! --vimgrep<space>

" Quickfix and Location list maps {{{1
let g:lt_height = get( g:, 'lt_height', 10 )

function! s:BufferCount()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function! s:LListToggle()
    let buffer_count_before = s:BufferCount()
    " Location list can't be closed if there's cursor in it, so we need
    " to call lclose twice to move cursor to the main pane
    silent! lclose
    silent! lclose

    if s:BufferCount() == buffer_count_before
        execute "silent! lopen " . g:lt_height
    endif
endfunction
command!  LToggle call s:LListToggle()
nnoremap <silent> <leader>l :LToggle<CR>

function! s:QListToggle()
    let buffer_count_before = s:BufferCount()
    silent! cclose

    if s:BufferCount() == buffer_count_before
        execute "silent! botright copen " . g:lt_height
    endif
endfunction
command!  QToggle call s:QListToggle()
nnoremap <silent> <leader>m :QToggle<CR>

" Filter from quickfix list - someone's vimrc {{{1
function! GrepQuickFix(pat)
    let qfl = getqflist()
    for d in qfl
        if bufname(d['bufnr']) !~ a:pat && d['text'] !~ a:pat
            call remove(qfl, index(qfl,d))
        endif
    endfor
    call setqflist(qfl)
endfunction
command! -nargs=* QFilter call GrepQuickFix(<q-args>)
nnoremap M :QFilter<Space>

" Filter from location list {{{3
function! GrepLocList(pat)
    let ll = getloclist(0)
    for d in ll
        if bufname(d['bufnr']) !~ a:pat && d['text'] !~ a:pat
            call remove(ll, index(ll,d))
        endif
    endfor
    call setloclist(0,ll)
endfunction
command! -nargs=* LFilter call GrepLocList(<q-args>)
nnoremap L :LFilter<Space>

