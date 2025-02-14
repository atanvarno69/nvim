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
        { win = "list", border = "none" },
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
    opts = {
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
    },
    keys = {
        {
            "<leader><Tab>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
            mode = "n",
        },
    },
}
