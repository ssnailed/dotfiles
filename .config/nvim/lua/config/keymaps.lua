local M = {}

local maps = {
    general = {
        n = {
            -- Resize windows with arrows
            { "<C-Up>", ":resize -2<CR>" },
            { "<C-Down>", ":resize +2<CR>" },
            { "<C-Left>", ":vertical resize -2<CR>" },
            { "<C-Right>", ":vertical resize +2<CR>" },
            -- Navigate buffers
            { "<TAB>", ":bnext<CR>" },
            { "<S-TAB>", ":bprevious<CR>" },
            -- lsp
            { "gD", vim.lsp.buf.declaration },
            { "gd", vim.lsp.buf.definition },
            { "K",  vim.lsp.buf.hover },
            { "gI", vim.lsp.buf.implementation },
            { "gr", vim.lsp.buf.references },
            { "gl", vim.diagnostic.open_float },
        },
        i = {
            -- Delete last word with ctrl + del
            { "<C-BS>", "<C-W>" },
        },
        v = {
            -- Better paste
            { "p", '"_dP' },
            -- Stay in indent mode
            { "<", "<gv" },
            { ">", ">gv" },
        }
    },
    bufferline = {
        n = {
            { "<TAB>", "<cmd>BufferLineCycleNext<CR>" },
            { "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>" },
        }
    },
    blankline = {
        n = {
            { "<c-c>",
                function()
                    local ok, start = require("indent_blankline.utils").get_current_context(
                        vim.g.indent_blankline_context_patterns,
                        vim.g.indent_blankline_use_treesitter_scope
                    )
                    if ok then
                        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                        vim.cmd [[normal! _]]
                    end
                end
            }
        }
   },
}

local wkmaps = {
    general = {
        n = {
            ["w"] = { "<cmd>w!<CR>", "Save" },
            ["q"] = { require("funcs").buf_kill, "Close" },
            ["h"] = { "<cmd>nohlsearch<CR>", "Clear Highlights" },
            ["n"] = { "<cmd>ene<CR>", "New File" },
            u = {
                name = "Utility",
                c = { "<cmd>w!<CR><cmd>!compiler \"%:p\"<CR>", "Compile" },
            },
            l = {
                name = "LSP",
                a = { vim.lsp.buf.code_action, "Code Action" },
                f = { function() require("funcs").format({ async = true }) end, "Format" },
                j = { vim.diagnostic.goto_next, "Next Diagnostic" },
                k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
                l = { vim.lsp.codelens.run, "CodeLens Action" },
                q = { vim.diagnostic.setloclist, "Quickfix" },
                r = { vim.lsp.buf.rename, "Rename" },
            }

        }
    },
    lspconfig = {
        n = {
            l = {
                name = "LSP",
                i = { "<cmd>LspInfo<cr>", "LSP Info" },
            }
        }
    },
    mason = {
        n = {
            l = {
                name = "LSP",
                I = { "<cmd>Mason<cr>", "Mason Info" },
            }
        }
    },
    dap = {
        n = {
            d = {
                name = "DAP",
                b = { require("dap").toggle_breakpoint, "Toggle Breakpoint" },
                c = { require("dap").continue, "Continue" },
                i = { require("dap").step_into, "Step Into" },
                o = { require("dap").step_over, "Step Over" },
                O = { require("dap").step_out, "Step Out" },
                r = { require("dap").repl.toggle, "Toggle REPL" },
                l = { require("dap").run_last, "Run Last" },
                t = { require("dap").terminate, "Stop Debugger" },
                u = { require("dapui").toggle, "Toggle DAP UI" },
            }
        }
    },
    bufferline = {
        n = {
            b = {
                name = "Buffers",
                j = { "<cmd>BufferLinePick<CR>", "Jump" },
                b = { "<cmd>BufferLineCyclePrev<CR>", "Previous" },
                n = { "<cmd>BufferLineCycleNext<CR>", "Next" },
                e = { "<cmd>BufferLinePickClose<CR>", "Pick which buffer to close" },
                h = { "<cmd>BufferLineCloseLeft<CR>", "Close all to the left" },
                l = { "<cmd>BufferLineCloseRight<CR>", "Close all to the right" },
                D = { "<cmd>BufferLineSortByDirectory<CR>", "Sort by directory" },
                L = { "<cmd>BufferLineSortByExtension<CR>", "Sort by language" },
            },
        }
    },
    packer = {
        n = {
            p = {
                name = "Packer",
                c = { "<cmd>PackerCompile<CR>", "Compile" },
                C = { "<cmd>PackerClean<CR>", "Clean" },
                i = { "<cmd>PackerInstall<CR>", "Install" },
                s = { "<cmd>PackerSync<CR>", "Sync" },
                S = { "<cmd>PackerStatus<CR>", "Status" },
                u = { "<cmd>PackerUpdate<CR>", "Update" },
            },
        }
    },
    lf = {
        n = {
            ["e"] = { require("lf").start, "File Picker" },
        }
    },
    treesitter = {
        n = {
            T = {
                name = "Treesitter",
                i = { "<cmd>TSConfigInfo<cr>", "Info" },
            },
        }
    },
    comment = {
        n = {
            ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
        },
        v = {
            ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise" },
        },
    },
    gitsigns = {
        n = {
            g = {
                name = "Git",
                j = { require("gitsigns").next_hunk, "Next Hunk" },
                k = { require("gitsigns").prev_hunk, "Prev Hunk" },
                l = { require("gitsigns").blame_line, "Blame" },
                p = { require("gitsigns").preview_hunk, "Preview Hunk" },
                r = { require("gitsigns").reset_hunk, "Reset Hunk" },
                R = { require("gitsigns").reset_buffer, "Reset Buffer" },
                s = { require("gitsigns").stage_hunk, "Stage Hunk" },
                u = { require("gitsigns").undo_stage_hunk, "Undo Stage Hunk" },
                d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
            },
        }
    }
}

local wk_ok, whichkey = pcall(require, 'which-key')

M.map = function(section)
    if maps[section] then
        for mode, binds in pairs(maps[section]) do
            for _, bind in pairs(binds) do
                local key = bind[1]
                local cmd = ""
                local opt = { silent = true, noremap = true }
                if type(bind[2]) == "string" then
                    cmd = bind[2]
                elseif type(bind[2]) == "function" then
                    opt["callback"] = bind[2]
                end
                vim.api.nvim_set_keymap(mode, key, cmd, opt)
            end
        end
    end

    if wk_ok then
        if wkmaps[section] then
            for mode, binds in pairs(wkmaps[section]) do
                whichkey.register(binds, {
                    mode = mode,
                    prefix = "<leader>",
                    buffer = nil,
                    silent = true,
                    noremap = true,
                    nowait = true,
                })
            end
        end
    end
end

return M
