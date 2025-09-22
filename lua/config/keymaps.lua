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

return {
    { "<leader>L", "<Cmd>Lazy<CR>", desc = "Lazy" },
    { "<leader>e", vim.diagnostic.open_float, desc = "Show diagnostic error messages" },
    { "<leader>q", vim.diagnostic.setloclist, desc = "Quickfix list" },
    { "<Esc>", "<Cmd>nohlsearch<CR>", desc = "Clear search highlighting" },
    { "<C-->", "<Cmd>bprevious<CR>", desc = "Previous buffer", mode = { "n", "i" } },
    { "<C-=>", "<Cmd>bnext<CR>", desc = "Next buffer", mode = { "n", "i" } },

    -- Sensible keymaps (normal mode)
    { "<Tab>", ">>", desc = "Indent line" },
    { "<S-Tab>", "<<", desc = "Dedent line" },
    { "<C-Del>", '"_dd', desc = "Delete line" },
    { "<C-c>", "yy", desc = "Copy line" },
    { "<C-d>", '"ayy"ap', desc = "Duplicate line" },
    { "<C-v>", smart_paste_normal, expr = true, desc = "Paste" },
    { "<C-x>", "dd", desc = "Cut line" },
    { "<C-y>", "<C-r>", desc = "Redo" },
    { "<C-z>", "u", desc = "Undo" },

    -- Sensible keybinds (insert mode)
    { "<C-Del>", '<C-o>"_dd', desc = "Delete line", mode = "i" },
    { "<C-c>", "<C-o>yy", desc = "Copy line", mode = "i" },
    { "<C-d>", '<C-o>"ayy<C-o>"ap', desc = "Duplicate line", mode = "i" },
    { "<C-v>", smart_paste_insert, expr = true, desc = "Paste", mode = "i" },
    { "<C-x>", "<C-o>dd", desc = "Cut line", mode = "i" },
    { "<C-y>", "<C-o><C-r>", desc = "Redo", mode = "i" },
    { "<C-z>", "<C-o>u", desc = "Undo", mode = "i" },

    -- Sensible keybinds (visual mode)
    { "<Del>", '"_d', desc = "Delete", mode = "v" },
    { "<Tab>", ">", desc = "Indent", mode = "v" },
    { "<S-Tab>", "<", desc = "Dedent", mode = "v" },
    { "<C-c>", "y", desc = "Copy", mode = "v" },
    { "<C-v>", '"_dP', desc = "Paste", mode = "v" },
    { "<C-x>", "x", desc = "Cut", mode = "v" },
    { "<C-z>", "o<Esc>u", desc = "Undo", mode = "v" },

    -- Sensible keybinds (normal and visual mode)
    { "c", '"_c', desc = "Change", mode = { "n", "v" } },
    { "r", '"_r', desc = "Replace", mode = { "n", "v" } },
    { "x", '"_x', desc = "Delete", mode = { "n", "v" } },

    -- Sensible keybinds (normal, insert and visual mode)
    { "<C-q>", smart_quit, desc = "Close", mode = { "n", "i", "v" } },
    { "<C-s>", "<Cmd>w<CR>", desc = "Save", mode = { "n", "i", "v" } },
}
