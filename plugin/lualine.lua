vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { confirm = false })
require("lualine").setup({
    options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        always_divide_middle = false,
        globalstatus = true,
        padding = 0,
    },
    sections = {},
    inactive_sections = {},
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
                    lazy = "Lazy",
                    mason = "Mason",
                },
                padding = 1,
            },
        },
        lualine_x = {},
        lualine_y = {},
    },
})

vim.keymap.set({ "n", "i" }, "<C-1>", "<Cmd>LualineBuffersJump! 1<CR>", { desc = "Buffer 1" })
vim.keymap.set({ "n", "i" }, "<C-2>", "<Cmd>LualineBuffersJump! 2<CR>", { desc = "Buffer 2" })
vim.keymap.set({ "n", "i" }, "<C-3>", "<Cmd>LualineBuffersJump! 3<CR>", { desc = "Buffer 3" })
vim.keymap.set({ "n", "i" }, "<C-4>", "<Cmd>LualineBuffersJump! 4<CR>", { desc = "Buffer 4" })
vim.keymap.set({ "n", "i" }, "<C-5>", "<Cmd>LualineBuffersJump! 5<CR>", { desc = "Buffer 5" })
vim.keymap.set({ "n", "i" }, "<C-6>", "<Cmd>LualineBuffersJump! 6<CR>", { desc = "Buffer 6" })
vim.keymap.set({ "n", "i" }, "<C-7>", "<Cmd>LualineBuffersJump! 7<CR>", { desc = "Buffer 7" })
vim.keymap.set({ "n", "i" }, "<C-8>", "<Cmd>LualineBuffersJump! 8<CR>", { desc = "Buffer 8" })
vim.keymap.set({ "n", "i" }, "<C-9>", "<Cmd>LualineBuffersJump! 9<CR>", { desc = "Buffer 9" })
vim.keymap.set({ "n", "i" }, "<C-0>", "<Cmd>LualineBuffersJump! $<CR>", { desc = "Last buffer" })
