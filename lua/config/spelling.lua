-- Spell checking language
vim.opt.spelllang = "en_gb"

require("which-key").add({
    {
        "<leader>s",
        desc = "Spelling",
    },
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
    },
    {
        "<leader>sr",
        "<Cmd>spellrepall<CR>",
        desc = "Repeat last correction",
    },
    {
        "<leader>sl",
        "]s",
        desc = "Next misspelled word",
        hidden = true,
    },
    {
        "<leader>sh",
        "[s",
        desc = "Previous misspelled word",
        hidden = true,
    },
    {
        "<leader>sa",
        "zg",
        desc = "Add to dictionary",
    },
    {
        "<leader>si",
        "zG",
        desc = "Ignore misspelling",
    },
    {
        "<leader>s<Right>",
        "]s",
        desc = "Next misspelled word",
    },
    {
        "<leader>s<Left>",
        "[s",
        desc = "Previous misspelled word",
    },
})
