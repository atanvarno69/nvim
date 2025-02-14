require("which-key").add({
    {
        "<leader>s<Tab>",
        function()
            vim.opt_local.spell = not (vim.opt_local.spell:get())
            vim.cmd("redraw")
            ---@diagnostic disable-next-line
            if vim.opt_local.spell:get() then
                print("Spell checking enabled.")
            else
                print("Spell checking disabled.")
            end
        end,
        desc = "Toggle spell check",
    },
    {
        "<leader>ss",
        "<Cmd>WhichKey z=<CR>",
        desc = "Correction suggestions",
        icon = { icon = "󱓳", color = "green" },
    },
    {
        "<leader>sr",
        "<Cmd>spellrepall<CR>",
        desc = "Repeat last correction",
        icon = { icon = "󱚗", color = "green" },
    },
    {
        "<leader>sl",
        "]s",
        desc = "Next misspelled word",
        icon = { icon = "󱚂" },
        hidden = true,
    },
    {
        "<leader>sh",
        "[s",
        desc = "Previous misspelled word",
        icon = { icon = "󱚀" },
        hidden = true,
    },
    {
        "<leader>sa",
        "zg",
        desc = "Add to dictionary",
        icon = { icon = "󰗛", color = "cyan" },
    },
    {
        "<leader>si",
        "zG",
        desc = "Ignore misspelling",
        icon = { icon = "󱚆", color = "orange" },
    },
    {
        "<leader>s<Right>",
        "]s",
        desc = "Next misspelled word",
        icon = { icon = "󱚂" },
    },
    {
        "<leader>s<Left>",
        "[s",
        desc = "Previous misspelled word",
        icon = { icon = "󱚀" },
    },
})
