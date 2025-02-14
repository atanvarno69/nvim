return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        "luukvbaal/statuscol.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    init = function()
        vim.opt.foldcolumn = "1"
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true
        vim.opt.fillchars = { foldopen = "", foldclose = "", foldsep = " ", fold = "." }
    end,
    opts = {
        provider_selector = function(_, ft, _)
            -- INFO: some filetypes only allow indent, some only LSP, some only
            -- treesitter. However, ufo only accepts two kinds as priority,
            -- therefore making this function necessary :/
            local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
            if vim.tbl_contains(lspWithOutFolding, ft) then
                return { "treesitter", "indent" }
            end
            return { "lsp", "indent" }
        end,
        -- when opening the buffer, close these fold kinds
        -- use `:UfoInspect` to get available fold kinds from the LSP
        open_fold_hl_timeout = 800,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
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
        end,
    },
    event = { "VimEnter" },
    keys = {
        {
            "zR",
            function()
                require("ufo").openAllFolds()
            end,
            desc = "Open all folds",
            mode = "n",
        },
        {
            "zM",
            function()
                require("ufo").closeAllFolds()
            end,
            desc = "Close all folds",
            mode = "n",
        },
    },
}
