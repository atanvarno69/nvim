-- Line numbers
vim.o.number = true

-- Minimum space for line numbers
vim.o.numberwidth = 1

-- Highlight search results
vim.o.hlsearch = true

-- :split to the right
vim.o.splitright = true

-- :vsplit to the bottom
vim.o.splitbelow = true

-- Preserve indent on wrapped lines
vim.o.breakindent = true

-- Word wrap
vim.o.linebreak = true

-- Sync clipboard between OS and Neovim
-- Schedule the setting after `UiEnter` because it can increase startup-time
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Display whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = "  ⇥", trail = "·", nbsp = "␣" }

-- Arrow key wrapping
vim.opt.whichwrap = "<,>,[,]"

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
