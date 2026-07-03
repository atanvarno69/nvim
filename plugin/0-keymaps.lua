vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function at_line_end()
    local line = vim.api.nvim_get_current_line()
    return vim.api.nvim_win_get_cursor(0)[2] >= #line
end

local function smart_paste_insert()
    return at_line_end() and "<C-o>p" or "<C-o>P"
end

local function smart_paste_normal()
    return at_line_end() and "p" or "P"
end

local function smart_quit()
    local listed_buffers = vim.tbl_filter(function(b)
        return vim.fn.buflisted(b) == 1
    end, vim.api.nvim_list_bufs())
    if #listed_buffers == 1 then
        vim.cmd("quit")
    else
        vim.cmd("bdelete")
    end
end

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix list" })
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })
vim.keymap.set({ "n", "i" }, "<C-->", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set({ "n", "i" }, "<C-=>", "<Cmd>bnext<CR>", { desc = "Next buffer" })

-- Sensible keymaps (normal mode)
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Dedent line" })
vim.keymap.set("n", "<C-Del>", '"_dd', { desc = "Delete line" })
vim.keymap.set("n", "<C-c>", "yy", { desc = "Copy line" })
vim.keymap.set("n", "<C-d>", '"ayy"ap', { desc = "Duplicate line" })
vim.keymap.set("n", "<C-v>", smart_paste_normal, { desc = "Paste", expr = true })
vim.keymap.set("n", "<C-x>", "dd", { desc = "Cut line" })
vim.keymap.set("n", "<C-y>", "<C-r>", { desc = "Redo" })
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })

-- Sensible keybinds (insert mode)
vim.keymap.set("i", "<C-Del>", '<C-o>"_dd', { desc = "Delete line" })
vim.keymap.set("i", "<C-c>", "<C-o>yy", { desc = "Copy line" })
vim.keymap.set("i", "<C-d>", '<C-o>"ayy<C-o>"ap', { desc = "Duplicate line" })
vim.keymap.set("i", "<C-v>", smart_paste_insert, { desc = "Paste", expr = true })
vim.keymap.set("i", "<C-x>", "<C-o>dd", { desc = "Cut line" })
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo" })

-- Sensible keybinds (visual mode)
vim.keymap.set("v", "<Del>", '"_d', { desc = "Delete" })
vim.keymap.set("v", "<Tab>", ">", { desc = "Indent" })
vim.keymap.set("v", "<S-Tab>", "<", { desc = "Dedent" })
vim.keymap.set("v", "<C-c>", "y", { desc = "Copy" })
vim.keymap.set("v", "<C-v>", '"_dP', { desc = "Paste" })
vim.keymap.set("v", "<C-x>", "x", { desc = "Cut" })
vim.keymap.set("v", "<C-z>", "o<Esc>u", { desc = "Undo" })

-- Sensible keybinds (normal and visual mode)
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change" })
vim.keymap.set({ "n", "v" }, "r", '"_r', { desc = "Replace" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete" })

-- Sensible keybinds (normal, insert and visual mode)
vim.keymap.set({ "n", "i", "v" }, "<C-q>", smart_quit, { desc = "Close" })
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Cmd>w<CR>", { desc = "Save" })

-- Plugins
vim.keymap.set("n", "<leader>U", vim.pack.update, { desc = "Update plugins" })
