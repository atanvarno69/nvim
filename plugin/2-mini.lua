vim.pack.add({
    { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
}, { confirm = false })

-- Icons
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- ai
require("mini.ai").setup()

-- Clue
require("mini.clue").setup({
    clues = {
        { mode = "n", keys = "<leader>l", desc = "+ LSP" },
        { mode = "n", keys = "<leader>s", desc = "+ Spelling" },
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.z(),
    },
    triggers = {
        { mode = { "n", "x" }, keys = "<leader>" },
        { mode = "n",          keys = "[" },
        { mode = "n",          keys = "]" },
        { mode = { "n", "x" }, keys = "g" },
        { mode = { "n", "x" }, keys = "z" },
    },
    window = {
        delay = 200,
        config = {
            width = "auto",
        },
    },
})

-- Git
require("mini.git").setup()

-- Pairs
require("mini.pairs").setup()

-- Surround
require("mini.surround").setup()

-- Diff
require("mini.diff").setup({
    view = {
        style = "sign",
        signs = { add = "│", change = "│", delete = "│" },
    },
})

-- Status line
local statusline = require("mini.statusline")

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniGitUpdated",
    callback = function()
        vim.cmd("redrawstatus")
    end,
})

local function add_hl(text, hl)
    text = text or ""
    hl = hl or ""
    return "%#" .. hl .. "#" .. text
end

local function section_mode(args)
    args = args or {}
    if statusline.is_truncated(args.trunc_width) then
        return ""
    end
    local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
    mode = string.format(" %s", mode:upper())
    return mode, mode_hl
end

local function section_filename(args)
    args = args or {}
    local filename_hl = "MiniStatuslineFilename"
    local tail = vim.fn.expand("%:t")
    if tail == "" then
        tail = "[No Name]"
    end
    local path = statusline.is_truncated(args.trunc_width) and "%t" or "%f"
    local filename = path .. ":%l:%v"
    if vim.bo.modified then
        filename = filename .. add_hl("", "DiagnosticSignWarn")
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
        filename = filename .. add_hl(" ", "DiagnosticSignError")
    end
    local icon, icon_hl = MiniIcons.get("file", tail)
    local icon_filename = add_hl(icon, icon_hl) .. " " .. add_hl(filename, filename_hl)
    return icon_filename, filename_hl
end

local function section_git(args)
    args = args or {}
    if statusline.is_truncated(args.trunc_width) then
        return ""
    end
    local data = vim.b.minigit_summary
    if data == nil or vim.tbl_isempty(data) then
        return ""
    end
    local root_name = data.root and vim.fn.fnamemodify(data.root, ":t") or ""
    return add_hl(" " .. root_name, "MiniIconsBlue") .. " " .. add_hl(" " .. (data.head_name or ""), "MiniIconsGreen")
end

local function section_diff(args)
    args = args or {}
    if statusline.is_truncated(args.trunc_width) then
        return ""
    end
    local data = vim.b.minidiff_summary
    if data == nil or vim.tbl_isempty(data) then
        return ""
    end
    local output = {}
    if data.add ~= nil and data.add > 0 then
        output[#output + 1] = add_hl(" " .. data.add, "MiniDiffSignAdd")
    end
    if data.change ~= nil and data.change > 0 then
        output[#output + 1] = add_hl(" " .. data.change, "MiniDiffSignChange")
    end
    if data.delete ~= nil and data.delete > 0 then
        output[#output + 1] = add_hl(" " .. data.delete, "MiniDiffSignDelete")
    end
    return table.concat(output, " ")
end

local function section_fileinfo(args)
    args = args or {}
    if statusline.is_truncated(args.trunc_width) then
        return ""
    end
    local format_icon = {
        unix = "",
        dos = "",
        mac = "",
    }
    local format = vim.bo.fileformat
    local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
    local wc = vim.fn.wordcount()
    return string.format("%s %s  %d  %d", format_icon[format] or "", encoding, wc.chars or 0, wc.words or 0)
end

local function section_diagnostics(args)
    args = args or {}
    if statusline.is_truncated(args.trunc_width) then
        return ""
    end
    local diagnostic_info = {
        [vim.diagnostic.severity.ERROR] = { icon = "", hl = "DiagnosticSignError" },
        [vim.diagnostic.severity.WARN]  = { icon = "", hl = "DiagnosticSignWarn" },
        [vim.diagnostic.severity.INFO]  = { icon = "", hl = "DiagnosticSignInfo" },
        [vim.diagnostic.severity.HINT]  = { icon = "", hl = "DiagnosticSignHint" },
    }
    local counts = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 }
    for _, d in ipairs(vim.diagnostic.get(0)) do
        counts[d.severity] = counts[d.severity] + 1
    end
    local parts = {}
    for severity, info in ipairs(diagnostic_info) do
        local n = counts[severity]
        if n > 0 then
            local text = info.icon .. " " .. n
            table.insert(parts, add_hl(text, info.hl))
        end
    end
    return table.concat(parts, " ")
end

local function section_lsp(args)
    args = args or {}
    if statusline.is_truncated(args.trunc_width) then
        return ""
    end
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ""
    end
    local names = {}
    for _, client in ipairs(clients) do
        names[#names + 1] = add_hl(client.name, "MiniIconsBlue")
    end
    return " " .. table.concat(names, " ")
end

require("mini.statusline").setup({
    content = {
        active = function()
            local mode, mode_hl = section_mode({ trunc_width = 120 })
            local git = section_git({ trunc_width = 75 })
            local filename, filename_hl = section_filename({ trunc_width = 140 })
            local diff = section_diff({ trunc_width = 75 })
            local fileinfo = section_fileinfo({ trunc_width = 120 })
            local diagnostics = section_diagnostics({ trunc_width = 75 })
            local lsp = section_lsp({ trunc_width = 75 })

            return statusline.combine_groups({
                { hl = mode_hl,     strings = { mode } },
                { hl = filename_hl, strings = { git } },
                "%<",
                { hl = filename_hl, strings = { filename } },
                { hl = filename_hl, strings = { diff } },
                "%=",
                { hl = filename_hl, strings = { fileinfo } },
                { hl = filename_hl, strings = { diagnostics } },
                { hl = filename_hl, strings = { lsp } },
            })
        end,
    },
})
