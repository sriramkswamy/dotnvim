-- separate windows mappings if necessary
local on_windows = vim.loop.os_uname().version:match 'Windows'

--[[ Insert mode --]]

-- Maps to resemble readline bindings
vim.keymap.set('i', '<C-a>', '<home>', { silent = true, desc = 'start of line' })
vim.keymap.set('i', '<C-e>', '<end>', { silent = true, desc = 'end of line' })
vim.keymap.set('i', '<C-f>', '<right>', { silent = true, desc = 'forward char' })
vim.keymap.set('i', '<C-b>', '<left>', { silent = true, desc = 'backward char' })

-- simpler <C-x> maps
vim.keymap.set('i', '<C-p>', '<C-x><C-p>', { silent = true, desc = 'next word complete' })
vim.keymap.set('i', '<C-n>', '<C-x><C-n>', { silent = true, desc = 'prev word complete' })
vim.keymap.set('i', '<C-o>', '<C-x><C-o>', { silent = true, desc = 'omnicomplete' })
vim.keymap.set('i', '<C-t>', '<C-x><C-]>', { silent = true, desc = 'tag complete' })
vim.keymap.set('i', '<C-d>', '<C-x><C-k>', { silent = true, desc = 'dictionary complete' })
vim.keymap.set('i', '<C-c>', '<C-x><C-f>', { silent = true, desc = 'path complete' })

--[[ Command mode --]]

-- Maps to resemble readline bindings
vim.keymap.set('c', '<C-a>', '<home>', { silent = true, desc = 'start of line' })
vim.keymap.set('c', '<C-e>', '<end>', { silent = true, desc = 'end of line' })
vim.keymap.set('c', '<C-f>', '<right>', { silent = true, desc = 'forward char' })
vim.keymap.set('c', '<C-b>', '<left>', { silent = true, desc = 'backward char' })

--[[ Normal/Visual mode --]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- [[ Terminal mode --]]

-- normal mode in terminal
vim.keymap.set('n', '<C-t>', '<cmd>terminal<CR>', { silent = true, desc = 'open terminal' })
vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', { silent = true, desc = 'normal mode' })

-- [[ Operator mode --]]

-- entire file text object
-- vim.keymap.set({ 'o', 'x' }, 'ia', '<cmd>normal! gg^vGg_<CR>', { silent = true, desc = 'all file' })
-- vim.keymap.set({ 'o', 'x' }, 'aa', '<cmd>normal! ggvG$<CR>', { silent = true, desc = 'all file' })

--[[ Visual mode --]]

-- Clipboard
vim.keymap.set('v', 'gp', '"+p', { silent = true, desc = 'clipboard paste' })
vim.keymap.set('v', 'gy', '"+y', { silent = true, desc = 'clipboard yank' })

-- Keep indenting in visual mode
vim.keymap.set('v', '>', '>gv', { silent = true, desc = 'indent right' })
vim.keymap.set('v', '<', '<gv', { silent = true, desc = 'indent left' })

-- search the whole selection in visual star mode
vim.keymap.set('v', '*', '"1y<Esc>/<C-R>1<CR>', { silent = true})

-- duplicate selection
vim.keymap.set('v', 'g.', 'ygv<Esc>o<Esc>P', { silent = true, desc = 'duplicate selection' })

-- repeat in visual mode
vim.keymap.set('v', '.', '<cmd>normal .<CR>', { silent = true, desc = 'repeat' })

--[[ Normal mode --]]

-- open file
vim.cmd("nnoremap <leader>o :e<space>")

-- elementary split/join
vim.cmd([[map <Plug>ElementarySplit Dop==k$:call repeat#set("\<Plug>ElementarySplit", v:count)<CR>]])
vim.keymap.set('n', 'gS', '<Plug>ElementarySplit', { silent = true, desc = 'split line' })
vim.keymap.set('n', 'gJ', 'J', { silent = true, desc = 'join line' })

-- previous buffer
vim.keymap.set('n', 'g<space>','<cmd>b#<CR>', { silent = true, desc = 'previous buffer' })

-- repeat macro
vim.keymap.set('n', 'Q','@@', { silent = true, desc = 'repeat last macro' })

-- duplicate line
vim.keymap.set('n', 'g.','yyp', { silent = true, desc = 'duplicate line' })

-- Clipboard
vim.keymap.set('n', '<leader>p','"+p', { silent = true, desc = 'clipboard paste' })
vim.keymap.set('n', '<leader>y', '"+y', { silent = true, desc = 'clipboard yank' })
vim.keymap.set('n', '<leader>yy', '"+yy', { silent = true, desc = 'clipboard yank line' })
vim.keymap.set('n', '<leader>P', '"+p$', { silent = true, desc = 'clipboard paste eol' })
vim.keymap.set('n', '<leader>Y', '"+y$', { silent = true, desc = 'clipboard yank eol' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'up' })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'down' })

-- Add maps to some basic functionality
vim.keymap.set('n', 'w', '<C-w>', { silent = true, desc = 'window prefix' })
vim.keymap.set('n', 'wt', '<C-w>T', { silent = true, desc = 'Move window to tab' })
vim.keymap.set('n', 'ww', '<C-w><C-w>', { silent = true, desc = 'switch to window' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { silent = true, desc = 'quit' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { silent = true, desc = 'write' })
vim.keymap.set('n', '<leader>v', '<cmd>qall<cr>', { silent = true, desc = 'quit all' })
vim.keymap.set('n', '<leader>b', '<cmd>bd!<cr>', { silent = true, desc = 'kill buffer' })
vim.keymap.set('n', '<leader>B', '<cmd>budfo bd<cr>', { silent = true, desc = 'kill all buffers' })

-- Tabs
vim.keymap.set('n', '<leader><tab>', 'gt', { silent = true, desc = 'next tab' })
vim.keymap.set('n', '<leader><BS>', 'gT', { silent = true, desc = 'previous tab' })
vim.keymap.set('n', '<leader>1', '1gt', { silent = true, desc = 'tab 1' })
vim.keymap.set('n', '<leader>2', '2gt', { silent = true, desc = 'tab 2' })
vim.keymap.set('n', '<leader>3', '3gt', { silent = true, desc = 'tab 3' })
vim.keymap.set('n', '<leader>4', '4gt', { silent = true, desc = 'tab 4' })
vim.keymap.set('n', '<leader>5', '5gt', { silent = true, desc = 'tab 5' })
vim.keymap.set('n', '<leader>6', '6gt', { silent = true, desc = 'tab 6' })
vim.keymap.set('n', '<leader>7', '7gt', { silent = true, desc = 'tab 7' })
vim.keymap.set('n', '<leader>8', '8gt', { silent = true, desc = 'tab 8' })
vim.keymap.set('n', '<leader>9', '9gt', { silent = true, desc = 'tab 9' })
vim.keymap.set('n', '<leader>0', '0gt', { silent = true, desc = 'tab 0' })

-- Use arrow keys for navigating location and quickfix lists
vim.keymap.set('n', '<up>', '<cmd>lprevious<cr>', { silent = true, desc = 'previous loclist item' })
vim.keymap.set('n', '<down>', '<cmd>lnext<cr>', { silent = true, desc = 'next loclist item' })
vim.keymap.set('n', '<left>', '<cmd>cprevious<cr>', { silent = true, desc = 'previous quickfix item' })
vim.keymap.set('n', '<right>', '<cmd>cnext<cr>', { silent = true, desc = 'next quickfix item' })

-- Auto center on some commands
vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })
vim.keymap.set('n', 'G', 'Gzz', { silent = true })
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })
vim.keymap.set('n', 'j', 'gj', { silent = true })

-- Use tab for folding and reassign it's functionality
-- vim.keymap.set('n', '<C-p>', '<C-i>', { silent = true })
vim.keymap.set('n', '<C-i>', 'za', { silent = true })
vim.keymap.set('n', '<Tab>', 'za', { silent = true })

-- Zoom when in Tmux(>v1.8)
vim.keymap.set('n', '<leader>z', '<cmd>call system("tmux resize-pane -Z")<CR>', { silent = true, desc = "zoom in to tmux"})

--[[ Unimpaired mappings --]]
vim.keymap.set('n', '[q', '<cmd>cold<CR>', { silent = true, desc = 'previous quickfix list' })
vim.keymap.set('n', ']q', '<cmd>cnew<CR>', { silent = true, desc = 'next quickfix list' })
vim.keymap.set('n', '[Q', '<cmd>cfirst<CR>', { silent = true, desc = 'first quickfix list' })
vim.keymap.set('n', ']Q', '<cmd>clast<CR>', { silent = true, desc = 'last quickfix list' })
vim.keymap.set('n', '[l', '<cmd>lold<CR>', { silent = true, desc = 'previous location list' })
vim.keymap.set('n', ']l', '<cmd>lnew<CR>', { silent = true, desc = 'Next Location list' })
vim.keymap.set('n', '[L', '<cmd>lfirst<CR>', { silent = true, desc = 'first location list' })
vim.keymap.set('n', ']L', '<cmd>llast<CR>', { silent = true, desc = 'last location list' })

-- Toggle mappings
vim.keymap.set('n', 'coa', '<cmd>set scrollbind!<CR>', { silent = false, desc = 'toggle scrollbind' })
vim.keymap.set('n', 'coi', '<cmd>setlocal ignorecase!<CR>', { silent = false, desc = 'toggle ignorecase' })
vim.keymap.set('n', 'com', '<cmd>set colorcolumn=80<CR>', { silent = false, desc = 'enable margin' })
vim.keymap.set('n', 'col', '<cmd>set colorcolumn=0<CR>', { silent = false, desc = 'disable margin' })
vim.keymap.set('n', 'cop', '<cmd>setlocal paste!<CR>', { silent = false, desc = 'toggle paste' })
vim.keymap.set('n', 'coy', '<cmd>set ft?<CR>', { silent = false, desc = 'which filetype' })
