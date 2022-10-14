local kbopts = { silent = true, noremap = true }

return {
  kb = {
    ['n'] = { -- normal mode
      -- Better window navigation
      {"<C-h>", "<C-w>h", kbopts},
      {"<C-j>", "<C-w>j", kbopts},
      {"<C-k>", "<C-w>k", kbopts},
      {"<C-l>", "<C-w>l", kbopts},
      -- Resize with arrows
      {"<C-Up>", ":resize -2<CR>", kbopts},
      {"<C-Down>", ":resize +2<CR>", kbopts},
      {"<C-Left>", ":vertical resize -2<CR>", kbopts},
      {"<C-Right>", ":vertical resize +2<CR>", kbopts},
      -- Navigate buffers
      {"<S-l>", ":bnext<CR>", kbopts},
      {"<S-h>", ":bprevious<CR>", kbopts},
      -- LSP
      {"gD", "<cmd>lua vim.lsp.buf.declaration()", kbopts},
      {"gd", "<cmd>lua vim.lsp.buf.definition()", kbopts},
      {"K",  "<cmd>lua vim.lsp.buf.hover()", kbopts},
      {"gI", "<cmd>lua vim.lsp.buf.implementation()", kbopts},
      {"gr", "<cmd>lua vim.lsp.buf.references()", kbopts},
      {"gl", "<cmd>lua vim.diagnostic.open_float()", kbopts},
      -- Illuminate
      {'<a-n>', "<cmd>lua require('illuminate').next_reference{wrap=true}", kbopts},
      {'<a-p>', "<cmd>lua require('illuminate').next_reference{reverse=true,wrap=true}", kbopts},
    },
    ['i'] = { -- insert mode
      -- Delete last word with ctrl + del
      {"<C-BS>", "<C-W>", kbopts},
    },
    ['v'] = { -- visual mode
      -- Better paste
      {"p", '"_dP', kbopts},
      -- Stay in indent mode
      {"<", "<gv", kbopts},
      {">", ">gv", kbopts},
    },
    ['x'] = { -- visual block mode
    },
    ['t'] = { -- terminal mode
    },
    ['c'] = { -- command mode
    }
  },
  wk = {
    vopts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    },
    nopts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    },
    vmaps = {
      ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    },
    nmaps = {
      [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
      ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
      ["w"] = { "<cmd>w!<CR>", "Save" },
      ["c"] = { function() require("user.funcs").buf_kill() end, "Close" },
      -- TODO: filepicker ["f"] = {},
      ["h"] = { "<cmd>nohlsearch<CR>", "Clear Highlights" },
      ["e"] = { "<cmd>NvimTreeToggle<CR>", "Toggle Filetree" },
      b = {
        name = "Buffers",
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
        n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
        e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
        h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
        l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
        D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
        L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
      },
      p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
      },
      t = {
        name = "Todo Comments",
        j = { function() require("todo-comments").jump_next() end, "Next Comment" },
        k = { function() require("todo-comments").jump_prev() end, "Previous Comment" },
      },
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
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
      },
      l = {
        name = "LSP",
        a = { function() vim.lsp.buf.code_action() end, "Code Action" },
        d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        f = { function() vim.lsp.buf.format{ async = true }() end, "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Info" },
        j = { function() vim.diagnostic.goto_next() end, "Next Diagnostic" },
        k = { function() vim.diagnostic.goto_prev() end, "Prev Diagnostic" },
        l = { function() vim.lsp.codelens.run() end, "CodeLens Action" },
        q = { function() vim.diagnostic.setloclist() end, "Quickfix" },
        r = { function() vim.lsp.buf.rename() end, "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      },
      d = {
        name = "DAP",
        b = { function() require('dap').toggle_breakpoint() end, "Toggle Breakpoint"},
        c = { function() require('dap').continue() end, "Continue"},
        i = { function() require('dap').step_into() end, "Step Into"},
        o = { function() require('dap').step_over() end, "Step Over"},
        O = { function() require('dap').step_out() end, "Step Out"},
        r = { function() require('dap').repl.toggle() end, "Toggle REPL"},
        l = { function() require('dap').run_last() end, "Run Last"},
        u = { function() require('dapui').toggle() end, "Toggle DAP UI"},
        t = { function() require('dap').terminate() end, "Stop Debugger"},
      },
      u = {
        name = "Utility",
        c = { "<cmd>w!<CR><cmd>!compiler \"%:p\"<CR>", "Compile" },
      },
      s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
      },
      T = {
        name = "Treesitter",
        i = { "<cmd>TSConfigInfo<cr>", "Info" },
      },
    }
  }
}
