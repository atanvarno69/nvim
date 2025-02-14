return {
    {
        "folke/lazydev.nvim",
        opts = function(_, opts)
            opts.library = opts.library or {}
            opts.library[#opts.library + 1] = "~/.local/share/lua/factorio/"
        end,
    },
}
