local languages = {
    "bash",
    "c",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "html",
    "json",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "php",
    "query",
    "regex",
    "rust",
    "toml",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype) or ""
        if vim.treesitter.language.add(lang) then
            vim.treesitter.start()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end
})

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })
require("nvim-treesitter").setup()
require("nvim-treesitter").install(languages)
