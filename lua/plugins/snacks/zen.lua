return {
    "folke/snacks.nvim",
    opts = {
        zen = {
            toggles = {
                dim = false,
            },
            show = {
                statusline = true,
            },
            win = {
                backdrop = { transparent = false, blend = 99 },
                wo = { number = false, foldcolumn = "0", signcolumn = "no" },
            },
            on_open = function(_)
                require("virt-column").setup_buffer(vim.api.nvim_get_current_buf(), { enabled = false })
                require("ufo").openAllFolds()
                require("ufo").disable()
                require("snacks").indent.disable()
                if vim.bo.filetype == "markdown" then
                    vim.opt.conceallevel = 2
                end
            end,
            on_close = function(_)
                require("virt-column").setup_buffer(vim.api.nvim_get_current_buf(), { enabled = true })
                require("ufo").enable()
                require("snacks").indent.enable()
                if vim.bo.filetype == "markdown" then
                    vim.opt.conceallevel = 0
                end
            end,
        },
    },
    keys = {
        {
            "<leader>z",
            function()
                Snacks.zen.zen()
            end,
            desc = "Toggle zen mode",
            mode = "n",
        },
    },
}
