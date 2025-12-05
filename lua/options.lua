-- Set the title of the window
vim.o.title = true

-- Disable spellchecking
vim.o.spell = false

-- Automaticall read file changes if written by external program
vim.o.autoread = true

-- Autowrite buffer when moving between files
vim.o.autowrite = true

-- Hide unloaded buffers
vim.o.hidden = true

-- Keep an offset of 3 lines when screen limits are reached
vim.o.scrolloff = 3
vim.o.sidescrolloff = 3

-- Highlight the entire line where the cursor is present
vim.o.cursorline = true

-- Make line numbers default and also add relative line numbers
vim.wo.number = true
vim.wo.relativenumber = false

-- Remove tags from completion list
vim.o.complete = ".,w,b,u"

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,preview,longest'
vim.o.completeopt = 'menuone,noselect,popup'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Do not keep a swap file
vim.o.swapfile = false

-- Save undo history
vim.o.undofile = true

-- Set a different directory for storing undo states
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Add window position to the list of variables saved in a session
vim.o.sessionoptions = vim.o.sessionoptions .. ",winpos"

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set highlight on search and search incrementally
vim.o.hlsearch = false

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Restrict the number of folds
vim.o.foldnestmax = 4
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Show contextual empty characters
vim.o.listchars = "tab:=~,extends:>,precedes:<,nbsp:+,trail:-"
vim.o.showbreak = "_"

-- Wrap
vim.o.wrap = false
vim.wo.wrap = false
vim.o.whichwrap = vim.o.whichwrap .. ",<,>,h,l"

-- Split right and below instead of left and top
vim.o.splitright = true
vim.o.splitbelow = true

-- Use existing tab or new tab for opening quickfix files
vim.o.switchbuf = vim.o.switchbuf .. ",usetab,newtab"

-- do not show the tab line
vim.o.showtabline = 1

-- Path for the builtin 'find' command
vim.o.path = "."
vim.o.tags = vim.o.tags .. "../tags"

-- Ignore wildcards
vim.o.wildignore = "/tmp/*,*.swp,*.bak,*.pyc,*.class,*.tmp,*.aux,*.mp4,*.pdf,*.cache,*.synctex.gz"
vim.o.wildignore = vim.o.wildignore .. "*.gradle,*.plist,*.avi,*.mp3,*.flv,*.mkv,*.sparseimage,*.db,*.tbz,*.zip,*.so,*.crash"
vim.o.wildignore = vim.o.wildignore .. "*.fls,*.latexmk_db,*.toc,*.mobi,*.epub,*.fdb_latexmk,*.apk,*.xmi,*.lic,*.iso,*.pages"
vim.o.wildignore = vim.o.wildignore .. "*.key,*.pptx,*.xlsx,*.docx,*.rar"
vim.o.wildignore = vim.o.wildignore .. "*/.git/*,*/.hg/*,*/.svn/*"

-- Line wrapping and display
vim.o.wrap = false
vim.o.linebreak = true
vim.o.list = false

-- Take care of indentation
vim.o.smartindent = true
vim.o.expandtab = true

-- set grep program
if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = "rg --no-heading"
  vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m,%f"
elseif vim.fn.executable('ag') then
  vim.o.grepprg = "ag --nogroup --nocolor --vimgrep"
  vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m,%f"
end

-- Set the background to be light or dark
vim.o.background = 'light'
