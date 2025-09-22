return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    init = function(_)
        vim.cmd.colorscheme("catppuccin")
    end,
    opts = {
        flavour = "mocha",
        default_integrations = false,
        auto_integrations = true,
    },
    lazy = false,
}
