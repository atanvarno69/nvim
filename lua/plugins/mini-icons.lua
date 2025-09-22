return {
    "nvim-mini/mini.icons",
    version = false,
    opts = {},
    config = function(_, opts)
        require("mini.icons").setup(opts)
        MiniIcons.mock_nvim_web_devicons()
    end,
    event = { "VeryLazy" },
}
