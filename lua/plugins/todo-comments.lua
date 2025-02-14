return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        signs = false,
    },
    event = { "VimEnter" },
    keys = {
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Previous todo comment",
            mode = "n",
        },
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Next todo comment",
            mode = "n",
        },
    },
}
