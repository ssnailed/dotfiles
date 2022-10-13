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
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
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
      ["c"] = { require("user.funcs").buf_kill, "Close" },
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
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
        g = { _LAZYGIT_TOGGLE, "Toggle Lazygit"}
      },
      l = {
        name = "LSP",
        a = { vim.lsp.buf.code_action, "Code Action" },
        d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        f = { vim.lsp.buf.format{ async = true }, "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Info" },
        j = { vim.diagnostic.goto_next, "Next Diagnostic" },
        k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
        l = { vim.lsp.codelens.run, "CodeLens Action" },
        q = { vim.diagnostic.setloclist, "Quickfix" },
        r = { vim.lsp.buf.rename, "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      },
      d = {
        name = "DAP",
        b = { require('dap').toggle_breakpoint, "Toggle Breakpoint"},
        c = { require('dap').continue, "Continue"},
        i = { require('dap').step_into, "Step Into"},
        o = { require('dap').step_over, "Step Over"},
        O = { require('dap').step_out, "Step Out"},
        r = { require('dap').repl.toggle, "Toggle REPL"},
        l = { require('dap').run_last, "Run Last"},
        u = { require('dapui').toggle, "Toggle DAP UI"},
        t = { require('dap').terminate, "Stop Debugger"},
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
