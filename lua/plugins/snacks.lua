local sidebar = {
    preview = false,
    layout = {
        backdrop = false,
        width = 30,
        min_width = 30,
        height = 0,
        position = "left",
        border = "none",
        box = "vertical",
        {
            win = "list",
            border = "none",
        },
        {
            win = "input",
            height = 1,
            border = "single",
            title = "{title} {live} {flags}",
            title_pos = "center",
        },
    },
}

return {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
        dashboard = { enabled = false },
        dim = {
            animate = { enabled = false },
        },
        explorer = { enabled = false },
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
        notifier = {
            timeout = 5000,
            icons = {
                error = " ",
                warn = " ",
                info = " ",
                debug = " ",
                trace = " ",
            },
        },
        picker = {
            sources = {
                buffers = {
                    sort_lastused = false,
                    layout = sidebar,
                    auto_close = true,
                    focus = "list",
                },
            },
        },
        quickfile = { enabled = false },
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
    lazy = false,
    keys = {
        {
            "<leader><Tab>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
            mode = "n",
        },
        {
            "<leader>N",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notification history",
            mode = "n",
        },
        {
            "<leader>n",
            function()
                Snacks.notifier.hide()
            end,
            desc = "Hide notifications",
            mode = "n",
        },
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
