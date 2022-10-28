local M = {}
M.maps = {
  general = {
    n = { -- normal mode
      -- Better window navigation
      { "<C-h>", "<C-w>h" },
      { "<C-j>", "<C-w>j" },
      { "<C-k>", "<C-w>k" },
      { "<C-l>", "<C-w>l" },
      -- Resize with arrows
      { "<C-Up>", ":resize -2<CR>" },
      { "<C-Down>", ":resize +2<CR>" },
      { "<C-Left>", ":vertical resize -2<CR>" },
      { "<C-Right>", ":vertical resize +2<CR>" },
      -- Navigate buffers
      { "<TAB>", ":bnext<CR>" },
      { "<S-TAB>", ":bprevious<CR>" },
      -- lsp
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
      { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
      { "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
      { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
      { "gl", "<cmd>lua vim.diagnostic.open_float()<CR>" },
    },
    i = { -- insert mode
      -- Delete last word with ctrl + del
      { "<C-BS>", "<C-W>" },
    },
    v = { -- visual mode
      -- Better paste
      { "p", '"_dP' },
      -- Stay in indent mode
      { "<", "<gv" },
      { ">", ">gv" },
    }
  },
  illuminate = {
    n = {
      { "<a-n>", "<cmd>lua require('illuminate').next_reference{wrap=true}<CR>" },
      { "<a-p>", "<cmd>lua require('illuminate').next_reference{reverse=true,wrap=true}<CR>" },
    }
  },
}

M.whichkey = {
  general = {
    n = {
      ["w"] = { "<cmd>w!<CR>", "Save" },
      ["q"] = { function() require("funcs").buf_kill() end, "Close" },
      ["f"] = { function() require("lf").start("~") end, "File Picker" },
      ["h"] = { "<cmd>nohlsearch<CR>", "Clear Highlights" },
      u = {
        name = "Utility",
        c = { "<cmd>w!<CR><cmd>!compiler \"%:p\"<CR>", "Compile" },
      },
      l = {
        name = "LSP",
        a = { function() vim.lsp.buf.code_action() end, "Code Action" },
        f = { function() vim.lsp.buf.format { async = true } end, "Format" },
        j = { function() vim.diagnostic.goto_next() end, "Next Diagnostic" },
        k = { function() vim.diagnostic.goto_prev() end, "Prev Diagnostic" },
        l = { function() vim.lsp.codelens.run() end, "CodeLens Action" },
        q = { function() vim.diagnostic.setloclist() end, "Quickfix" },
        r = { function() vim.lsp.buf.rename() end, "Rename" },
      }

    }
  },
  lspconfig = {
    n = {
      l = {
        name = "LSP",
        i = { "<cmd>LspInfo<cr>", "Info" },
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
        b = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
        c = { function() require("dap").continue() end, "Continue" },
        i = { function() require("dap").step_into() end, "Step Into" },
        o = { function() require("dap").step_over() end, "Step Over" },
        O = { function() require("dap").step_out() end, "Step Out" },
        r = { function() require("dap").repl.toggle() end, "Toggle REPL" },
        l = { function() require("dap").run_last() end, "Run Last" },
        t = { function() require("dap").terminate() end, "Stop Debugger" },
        u = { function() require("dapui").toggle() end, "Toggle DAP UI" },
      }
    }
  },
  telescope = {
    n = {
      b = {
        name = "Buffers",
        f = { "<cmd>Telescope buffers<CR>", "Find" },
      },
      g = {
        name = "Git",
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
      },
      l = {
        name = "LSP",
        d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      },
      s = {
        name = "Search",
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        T = { "<cmd>TodoTelescope<cr>", "Todo Comments" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
      }
    }
  },
  blankline = {
    n = {
      c = {
        function()
          local ok, start = require("indent_blankline.utils").get_current_context(
            vim.g.indent_blankline_context_patterns,
            vim.g.indent_blankline_use_treesitter_scope
          )
          if ok then
            vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
            vim.cmd [[normal! _]]
          end
        end,
        "Jump to current_context",
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
      ["e"] = { function() require('lf').start() end, "File Picker" },
    }
  },
  alpha = {
    n = {
      [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
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
    v = {
      ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise" },
    },
    n = {
      ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
    }
  },
  gitsigns = {
    n = {
      g = {
        name = "Git",
        j = { function() require("gitsigns").next_hunk() end, "Next Hunk" },
        k = { function() require("gitsigns").prev_hunk() end, "Prev Hunk" },
        l = { function() require("gitsigns").blame_line() end, "Blame" },
        p = { function() require("gitsigns").preview_hunk() end, "Preview Hunk" },
        r = { function() require("gitsigns").reset_hunk() end, "Reset Hunk" },
        R = { function() require("gitsigns").reset_buffer() end, "Reset Buffer" },
        s = { function() require("gitsigns").stage_hunk() end, "Stage Hunk" },
        u = { function() require("gitsigns").undo_stage_hunk() end, "Undo Stage Hunk" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
      },
    }
  }
}

return M
