return {
    "folke/snacks.nvim",
    opts = {
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
    },
    keys = {
        {
            "<leader>N",
            function()
                require("snacks").notifier.show_history()
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
    },
}
