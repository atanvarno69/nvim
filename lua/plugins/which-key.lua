local function basename(name)
    local parts = {}
    for part in string.gmatch(name, "[^/]+") do
        table.insert(parts, part)
    end
    return parts[#parts]
end

local spec = {
    -- Leader & lazy
    { "<leader>", group = "User defined", icon = { icon = "", color = "azure" } },
    { "<leader>L", "<Cmd>Lazy<CR>", desc = "Lazy", icon = { icon = "󰒲", color = "azure" } },
    { "<C-->", "<Cmd>bprevious<CR>", desc = "Previous buffer", mode = { "n", "i" } },
    { "<C-=>", "<Cmd>bnext<CR>", desc = "Next buffer", mode = { "n", "i" } },

    -- Diagnostics
    { "<leader>q", vim.diagnostic.setloclist, desc = "Quickfix list", icon = { icon = "", color = "blue" } },
    {
        "[d",
        function()
            vim.diagnostic.jump({ count = -1, float = true })
        end,
        desc = "Previous diagnostic message",
        icon = "",
    },
    {
        "]d",
        function()
            vim.diagnostic.jump({ count = 1, float = true })
        end,
        desc = "Next diagnostic message",
        icon = "",
    },
    {
        "<leader>e",
        vim.diagnostic.open_float,
        desc = "Show diagnostic error messages",
        icon = { icon = "", color = "red" },
    },

    -- Sensible keybinds (normal mode)
    { "<Esc>", "<Cmd>nohlsearch<CR>", desc = "Clear search highlighting", icon = "" },
    { "<Tab>", ">>", desc = "Indent line", icon = "" },
    { "<S-Tab>", "<<", desc = "Dedent line", icon = "" },
    { "<C-Del>", '"_dd', desc = "Delete line", icon = "" },
    { "<C-a>", "gg0vG$", desc = "Select all", icon = "󰒆" },
    { "<C-c>", "yy", desc = "Copy line", icon = "" },
    { "<C-d>", '"ayy"ap', desc = "Duplicate line" },
    { "<C-v>", "P", desc = "Paste", icon = "" },
    { "<C-x>", "dd", desc = "Cut line", icon = "󰆐" },
    { "<C-y>", "<C-r>", desc = "Redo", icon = "󰑎" },
    { "<C-z>", "u", desc = "Undo", icon = "󰕌" },

    -- Sensible keybinds (insert mode)
    { "<C-Del>", '<C-o>"_dd', desc = "Delete line", mode = "i", icon = "" },
    { "<C-c>", "<C-o>yy", desc = "Copy line", mode = "i", icon = "" },
    { "<C-d>", '<C-o>"ayy<C-o>"ap', desc = "Duplicate line", mode = "i" },
    { "<C-v>", "<C-o>P", desc = "Paste", mode = "i", icon = "" },
    { "<C-x>", "<C-o>dd", desc = "Cut line", mode = "i", icon = "󰆐" },
    { "<C-y>", "<C-o><C-r>", desc = "Redo", mode = "i", icon = "󰑎" },
    { "<C-z>", "<C-o>u", desc = "Undo", mode = "i", icon = "󰕌" },

    -- Sensible keybinds (visual mode)
    { "<Del>", '"_d', desc = "Delete", mode = "v", icon = "" },
    { "<Tab>", ">", desc = "Indent", mode = "v", icon = "" },
    { "<S-Tab>", "<", desc = "Dedent", mode = "v", icon = "" },
    { "<C-c>", "y", desc = "Copy", mode = "v", icon = "" },
    { "<C-v>", '"_dP', desc = "Paste", mode = "v", icon = "" },
    { "<C-x>", "x", desc = "Cut", mode = "v", icon = "󰆐" },
    { "<C-z>", "o<Esc>u", desc = "Undo", mode = "v", icon = "󰕌" },

    -- Sensible keybinds (normal and visual mode)
    { "c", '"_c', desc = "Change", mode = { "n", "v" } },
    { "r", '"_r', desc = "Replace", mode = { "n", "v" } },
    { "x", '"_x', desc = "Delete", mode = { "n", "v" }, icon = "" },

    -- Sensible keybinds (normal, insert and visual mode)
    {
        "<C-q>",
        function()
            local listed_buffers = vim.tbl_filter(function(b)
                return vim.fn.buflisted(b) == 1
            end, vim.api.nvim_list_bufs())
            if #listed_buffers == 1 then
                vim.cmd("quit")
            else
                -- require("snacks").bufdelete()
                vim.cmd("bdelete")
            end
        end,
        desc = "Close",
        mode = { "n", "i", "v" },
        icon = "",
    },
    {
        "<C-s>",
        function()
            local function write_file(filename)
                if type(filename) ~= "nil" and filename ~= "" then
                    vim.api.nvim_command("saveas " .. filename)
                else
                    print("No filename given.")
                end
            end
            -- Check if the buffer has a file associated with it
            if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "" then
                local name = vim.api.nvim_buf_get_name(0)
                if name ~= "" and basename(name) ~= "new" then
                    vim.api.nvim_command("write")
                else
                    -- If no file is associated, prompt for a filename
                    vim.ui.input({ prompt = "Filename: ", completion = "file" }, write_file)
                end
            else
                print("Cannot save this type of buffer.")
            end
        end,
        desc = "Save",
        mode = { "n", "i", "v" },
        icon = "",
    },
}

return {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
        spec = spec,
    },
    event = { "VeryLazy" },
}
