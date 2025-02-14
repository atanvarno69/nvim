return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        opts = {
            dashboard = { enabled = false },
            explorer = { enabled = false },
            quickfile = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            zen = { enabled = false },
        },
        lazy = false,
    },
    require("plugins.snacks.dim"),
    require("plugins.snacks.indent"),
    require("plugins.snacks.notifier"),
    require("plugins.snacks.picker"),
    require("plugins.snacks.statuscolumn"),
    require("plugins.snacks.styles"),
    require("plugins.snacks.zen"),
}
