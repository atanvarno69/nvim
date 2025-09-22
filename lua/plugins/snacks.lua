return {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
        bigfile = { enabled = false },
        dashboard = { enabled = false },
        dim = {
            animate = { enabled = false },
        },
        image = { enabled = false },
        indent = {
            indent = {
                char = "│",
                hl = { "rainbow6", "rainbow5", "rainbow4", "rainbow3", "rainbow2", "rainbow1" },
            },
            animate = { enabled = false },
            scope = { hl = "Keyword" },
            filter = function(buf)
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    and vim.bo[buf].filetype ~= "markdown"
            end,
        },
        input = { enabled = false },
        notifier = {
            enabled = true,
            timeout = 5000,
            icons = {
                error = " ",
                warn = " ",
                info = " ",
                debug = " ",
                trace = " ",
            },
        },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        styles = {
            blame_line = {
                border = "single",
            },
            input = {
                border = "single",
            },
            notification = {
                border = "single",
            },
            notification_history = {
                border = "single",
            },
            scratch = {
                border = "single",
            },
        },
        words = { enabled = false },
        zen = {
            toggles = {
                dim = false,
            },
            show = {
                statusline = true,
            },
            win = {
                backdrop = { transparent = false, blend = 99 },
                width = 120,
                wo = { number = false, foldcolumn = "0", signcolumn = "no", statuscolumn = "" },
            },
            on_open = function(win)
                require("virt-column").setup_buffer(vim.api.nvim_get_current_buf(), { enabled = false })
                require("ufo").openAllFolds()
                require("ufo").disable()
                require("snacks").indent.disable()
            end,
            on_close = function(win)
                require("virt-column").setup_buffer(vim.api.nvim_get_current_buf(), { enabled = true })
                require("ufo").enable()
                require("snacks").indent.enable()
            end,
        },
    },
    lazy = false,
    keys = {
        {
            "<leader>z",
            function()
                Snacks.zen.zen()
            end,
            desc = "Toggle zen mode",
        },
    },
}
