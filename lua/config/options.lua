vim.g.mapleader = " "
vim.g.maplocalleader = "//"

-- Make line numbers default
vim.opt.number = true
vim.opt.numberwidth = 1

-- Keep signcolumn on by default
-- vim.opt.signcolumn = "yes"

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search results
--  See keymaps: <Esc> in normal mode will clear highlights.
vim.opt.hlsearch = true

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ⇥", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Better navigation
vim.opt.whichwrap = "<,>,[,]"

-- Spell checking language
vim.opt.spelllang = "en_gb"

-- Word wrap
vim.opt.linebreak = true

-- Terminal colors
vim.opt.termguicolors = true

-- Mode is in status line
vim.opt.showmode = false

-- Disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})

