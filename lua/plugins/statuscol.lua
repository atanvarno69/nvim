return {
    "luukvbaal/statuscol.nvim",
    opts = function()
        local builtin = require("statuscol.builtin")
        return {
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
        }
    end,
    event = { "VimEnter" },
}
