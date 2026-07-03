vim.o.spelllang = "en_gb"
vim.keymap.set(
    "n",
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
    { desc = "Toggle spell check" }
)
vim.keymap.set("n", "<leader>ss", "z=", { desc = "Correction suggestions" })
vim.keymap.set("n", "<leader>sr", "<Cmd>spellrepall<CR>", { desc = "Repeat last correction" })
vim.keymap.set("n", "<leader>sl", "]s", { desc = "Next misspelled word" })
vim.keymap.set("n", "<leader>sh", "[s", { desc = "Previous misspelled word" })
vim.keymap.set("n", "<leader>sa", "zg", { desc = "Add to dictionary" })
vim.keymap.set("n", "<leader>si", "zG", { desc = "Ignore misspelling" })
vim.keymap.set("n", "<leader>s<Right>", "]s", { desc = "Next misspelled word" })
vim.keymap.set("n", "<leader>s<Left>", "[s", { desc = "Previous misspelled word" })
