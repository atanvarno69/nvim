return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = ":TSUpdate",
    init = function(_)
        vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site')
    end,
    opts = {
        ensure_installed = {
            "c",
            "diff",
            "html",
            "luadoc",
            "query",
            "vimdoc",
        },
        auto_install = true,
        indent = { enable = true },
        highlight = { enable = true },
        folds = { enable = true },
    },
    opts_extend = { "ensure_installed" },
    lazy = false,
}
