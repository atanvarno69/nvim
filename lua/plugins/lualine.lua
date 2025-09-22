local palette = require("catppuccin.palettes").get_palette("mocha")

local function git_compact(absolute_path)
    local git_dir = require("lualine.components.branch.git_branch").find_git_dir()
    if git_dir == nil or git_dir == "" then
        return absolute_path
    end
    local git_root = vim.fs.dirname(git_dir)
    return absolute_path:sub(git_root:len() + 2)
end

local function home_compact(absolute_path)
    local home = os.getenv("HOME")
    if home == nil then
        return absolute_path
    end
    local start, _ = absolute_path:find(home)
    if start ~= 1 then
        return absolute_path
    end
    return "~" .. absolute_path:sub(home:len() + 1, absolute_path:len())
end

local function is_new_file()
    local filename = vim.fn.expand("%")
    return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
end

local function filename()
    local abs_path = vim.fn.expand("%:p")
    local name = git_compact(abs_path)
    if name == abs_path then
        name = home_compact(abs_path)
    end
    name = name .. ":%l:%c"
    if vim.bo.modified then
        name = name .. " "
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
        name = name .. " "
    end
    if is_new_file() then
        name = name .. " "
    end
    return name
end

local function lsp_name()
    local output = ""
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
        return output
    end
    for index, client in ipairs(clients) do
        if index < #clients then
            output = output .. " "
        end
        output = output .. client.name
    end
    return output
end

local function repository()
    local git_dir = require("lualine.components.branch.git_branch").find_git_dir()
    if git_dir == nil or git_dir == "" then
        return ""
    end
    return vim.fs.basename(vim.fs.dirname(git_dir))
end

local function word_count()
    return tostring(vim.fn.wordcount().words)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
        options = {
            component_separators = { left = " ", right = " " },
            section_separators = { left = " ", right = " " },
            always_divide_middle = false,
            globalstatus = true,
            padding = 0,
        },
        sections = {
            lualine_a = {
                { "mode", icon = "", padding = 1 },
            },
            lualine_b = {
                {
                    repository,
                    color = { fg = palette.blue, bg = palette.surface0 },
                    icon = "",
                },
                {
                    "branch",
                    color = { fg = palette.green, bg = palette.surface0 },
                    icon = "",
                    padding = { right = 1 },
                },
                {
                    "diff",
                    symbols = { added = " ", modified = " ", removed = " " },
                    padding = { right = 1 },
                },
            },
            lualine_c = {
                { filename },
                { "progress" },
            },
            lualine_x = {
                { word_count, icon = "" },
            },
            lualine_y = {
                {
                    "diagnostics",
                    sources = { "nvim_lsp" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    padding = { left = 1 },
                },
                {
                    "filetype",
                    colored = true,
                    icon_only = true,
                    icon = { align = "left" },
                    padding = { left = 1 },
                },
                { lsp_name, padding = { right = 1 } },
            },
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {
            lualine_b = {
                {
                    "buffers",
                    show_filename_only = false,
                    mode = 2,
                    max_length = vim.o.columns,
                    symbols = {
                        modified = " ",
                        alternate_file = "",
                        directory = "",
                    },
                    filetype_names = {
                        oil = "Oil",
                        lazy = "Lazy",
                        mason = "Mason",
                    },
                    padding = 1,
                },
            },
            lualine_x = {},
            lualine_y = {},
        },
    },
    event = { "VeryLazy" },
    keys = {
        { "<C-1>", "<Cmd>LualineBuffersJump! 1<CR>", desc = "Buffer 1", mode = { "n", "i" } },
        { "<C-2>", "<Cmd>LualineBuffersJump! 2<CR>", desc = "Buffer 2", mode = { "n", "i" } },
        { "<C-3>", "<Cmd>LualineBuffersJump! 3<CR>", desc = "Buffer 3", mode = { "n", "i" } },
        { "<C-4>", "<Cmd>LualineBuffersJump! 4<CR>", desc = "Buffer 4", mode = { "n", "i" } },
        { "<C-5>", "<Cmd>LualineBuffersJump! 5<CR>", desc = "Buffer 5", mode = { "n", "i" } },
        { "<C-6>", "<Cmd>LualineBuffersJump! 6<CR>", desc = "Buffer 6", mode = { "n", "i" } },
        { "<C-7>", "<Cmd>LualineBuffersJump! 7<CR>", desc = "Buffer 7", mode = { "n", "i" } },
        { "<C-8>", "<Cmd>LualineBuffersJump! 8<CR>", desc = "Buffer 8", mode = { "n", "i" } },
        { "<C-9>", "<Cmd>LualineBuffersJump! 9<CR>", desc = "Buffer 9", mode = { "n", "i" } },
        { "<C-0>", "<Cmd>LualineBuffersJump! $<CR>", desc = "Last buffer", mode = { "n", "i" } },
    },
}
