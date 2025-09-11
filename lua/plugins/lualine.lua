local extension = require("plugins.lualine.extension")
local palette = require("catppuccin.palettes").get_palette("mocha")

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-mini/mini.icons",
    },
    opts = {
        options = {
            theme = "catppuccin",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            always_divide_middle = false,
            globalstatus = true,
            padding = 0,
        },
        sections = {
            lualine_a = { { "mode", icon = "", padding = 1 } },
            lualine_b = {
                {
                    extension.repo_name,
                    color = { fg = palette.blue, bg = palette.surface0 },
                    icon = extension.opts.repository.icon,
                    padding = 1,
                },
                { "branch", color = { fg = palette.green, bg = palette.surface0 }, icon = "", padding = { right = 1 } },
                { "diff", symbols = { added = " ", modified = " ", removed = " " }, padding = { right = 1 } },
            },
            lualine_c = {
                { "filetype", icon_only = true, padding = { left = 1 } },
                { extension.filename, padding = { right = 1 } },
                { "progress" },
            },
            lualine_x = {
                { "tostring(vim.fn.wordcount().words)", icon = "", padding = { right = 1 } },
                { "encoding", icon = "", padding = { right = 1 } },
            },
            lualine_y = {
                {
                    "diagnostics",
                    sources = { "nvim_lsp" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    padding = { left = 1 },
                },
                { extension.lsp, padding = 1 },
            },
            lualine_z = {},
        },
        inactive_sections = { lualine_c = {} },
        tabline = {
            lualine_b = {
                {
                    "buffers",
                    show_filename_only = false,
                    mode = 2,
                    max_length = vim.o.columns,
                    symbols = {
                        modified = " ",
                        alternate_file = "",
                        directory = "",
                    },
                    filetype_names = {
                        oil = "Oil",
                        lazy = "󰒲 Lazy",
                    },
                    padding = 1,
                },
            },
            lualine_c = { { "", draw_empty = true } },
        },
    },
    event = { "VeryLazy" },
    keys = {
        { "<C-1>", "<Cmd>LualineBuffersJump! 1<CR>", desc = "Buffer 1", mode = { "n", "i" } },
        { "<C-2>", "<Cmd>LualineBuffersJump! 2<CR>", desc = "Buffer 2", mode = { "n", "i" } },
        { "<C-3>", "<Cmd>LualineBuffersJump! 3<CR>", desc = "Buffer 3", mode = { "n", "i" } },
        { "<C-4>", "<Cmd>LualineBuffersJump! 4<CR>", desc = "Buffer 4", mode = { "n", "i" } },
        { "<C-5>", "<Cmd>LualineBuffersJump! 5<CR>", desc = "Buffer 5", mode = { "n", "i" } },
        { "<C-6>", "<Cmd>LualineBuffersJump! 6<CR>", desc = "Buffer 6", mode = { "n", "i" } },
        { "<C-7>", "<Cmd>LualineBuffersJump! 7<CR>", desc = "Buffer 7", mode = { "n", "i" } },
        { "<C-8>", "<Cmd>LualineBuffersJump! 8<CR>", desc = "Buffer 8", mode = { "n", "i" } },
        { "<C-9>", "<Cmd>LualineBuffersJump! 9<CR>", desc = "Buffer 9", mode = { "n", "i" } },
        { "<C-0>", "<Cmd>LualineBuffersJump! $<CR>", desc = "Last buffer", mode = { "n", "i" } },
    },
}
