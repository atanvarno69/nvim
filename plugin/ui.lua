vim.pack.add({
    "https://github.com/luukvbaal/statuscol.nvim",
    "https://github.com/lukas-reineke/virt-column.nvim",
    "https://github.com/kevinhwang91/promise-async",
    "https://github.com/kevinhwang91/nvim-ufo",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/folke/noice.nvim",
    "https://github.com/folke/snacks.nvim",
}, { confirm = false })

vim.g.virt_column_enabled = true
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.fillchars = { eob = " ", foldopen = "", foldclose = "", foldsep = " ", fold = "." }

local function provider_selector(bufnr, filetype, buftype)
    local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
    if vim.tbl_contains(lspWithOutFolding, filetype) then
        return { "treesitter", "indent" }
    end
    return { "lsp", "indent" }
end

local function fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = "  " .. tostring(endLnum - lnum) .. "…"
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    local rAlignAppndx = math.max(math.min(120, width - 1) - curWidth - sufWidth, 0)
    suffix = (" "):rep(rAlignAppndx) .. suffix
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

local builtin = require("statuscol.builtin")

require("statuscol").setup({
    segments = {
        {
            sign = {
                maxwidth = 1,
                colwidth = 2,
                auto = false,
                fillchar = " ",
                foldclosed = true,
                namespace = { "diagnostic*" },
            },
            click = "v:lua.ScSa",
        },
        {
            text = { builtin.lnumfunc },
            condition = { true, builtin.not_empty },
        },
        {
            sign = {
                maxwidth = 1,
                colwidth = 1,
                auto = false,
                fillchar = "│",
                foldclosed = true,
                namespace = { "MiniDiff*" },
            },
            click = "v:lua.ScSa",
        },
        {
            text = { builtin.foldfunc, " " },
            click = "v:lua.ScFa",
        },
    },
})

require("virt-column").setup({
    enabled = true,
    char = "▏",
    virtcolumn = "81,121",
    exclude = {
        filetypes = {
            "lspinfo",
            "checkhealth",
            "help",
            "man",
            "gitcommit",
            "oil",
        },
    },
})

require("ufo").setup({
    provider_selector = provider_selector,
    fold_virt_text_handler = fold_virt_text_handler,
})

require("noice").setup({
    views = {
        cmdline_popup = {
            border = { style = "single" },
        },
        popupmenu = {
            border = { style = "single" },
        },
    },
})

require("snacks").setup({
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    dim = {
        animate = { enabled = false },
    },
    image = { enabled = false },
    indent = {
        indent = {
            char = "│",
            hl = { "rainbow6", "rainbow5", "rainbow4", "rainbow3", "rainbow2", "rainbow1" },
        },
        animate = { enabled = false },
        scope = { hl = "Keyword" },
        filter = function(buf)
            return vim.g.snacks_indent ~= false
                and vim.b[buf].snacks_indent ~= false
                and vim.bo[buf].buftype == ""
                and vim.bo[buf].filetype ~= "markdown"
        end,
    },
    input = { enabled = false },
    notifier = {
        enabled = true,
        timeout = 5000,
        icons = {
            error = "",
            warn = "",
            info = "",
            debug = "",
            trace = "",
        },
    },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    styles = {
        blame_line = {
            border = "single",
        },
        input = {
            border = "single",
        },
        notification = {
            border = "single",
        },
        notification_history = {
            border = "single",
        },
        scratch = {
            border = "single",
        },
    },
    words = { enabled = false },
    zen = {
        toggles = {
            dim = false,
        },
        show = {
            statusline = true,
        },
        win = {
            backdrop = { transparent = false, blend = 99 },
            width = 120,
            wo = { number = false, foldcolumn = "0", signcolumn = "no", statuscolumn = "" },
        },
        on_open = function(win)
            require("virt-column").setup_buffer(vim.api.nvim_get_current_buf(), { enabled = false })
            require("ufo").openAllFolds()
            require("ufo").disable()
            require("snacks").indent.disable()
        end,
        on_close = function(win)
            require("virt-column").setup_buffer(vim.api.nvim_get_current_buf(), { enabled = true })
            require("ufo").enable()
            require("snacks").indent.enable()
        end,
    },
})

vim.keymap.set("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
vim.keymap.set("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
vim.keymap.set("n", "<leader>z", function() Snacks.zen.zen() end, { desc = "Toggle zen mode" })
vim.keymap.set(
    "n",
    "<leader>|",
    function()
        require("virt-column").update({ enabled = not vim.g.virt_column_enabled })
        vim.g.virt_column_enabled = not vim.g.virt_column_enabled
        vim.cmd("redraw!")
    end,
    { desc = "Toggle virtual column" }
)
