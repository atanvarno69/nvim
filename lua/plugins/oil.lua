return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        watch_for_changes = true,
        view_options = {
            show_hidden = true,
        },
        float = {
            border = "none",
        },
        keymaps_help = {
            border = "none",
        },
        use_default_keymaps = false,
        keymaps = {
            ["<Esc>"] = { "actions.close", mode = "n" },
            ["<CR>"] = { "actions.select", mode = "n" },
            ["?"] = { "actions.show_help", mode = "n" },
            ["-"] = { "actions.parent", mode = "n" },
            ["q"] = { "actions.close", mode = "n" },
            ["<C-c>"] = { "actions.copy_entry_path", mode = "n" },
            ["<C-p>"] = { "actions.preview", mode = "n" },
            ["<C-q>"] = { "actions.close", mode = { "n", "i" } },
            ["<C-s>"] = {
                callback = function()
                    require("oil").save()
                end,
                desc = "Save oil buffer",
                mode = { "n", "i" },
            },
        },
    },
    cmd = { "Oil" },
    event = "VimEnter",
    keys = {
        { "<leader>o", "<Cmd>Oil --float<CR>", desc = "Oil", mode = "n" },
    },
}
