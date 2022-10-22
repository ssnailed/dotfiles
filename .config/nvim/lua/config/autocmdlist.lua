return {
  { -- Handles the automatic line numeration changes
    { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
    {
      pattern = "*",
      command="if &nu && mode() != \"i\" | set rnu | endif"
    }
  },
  { -- Handles the automatic line numeration changes
    { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
    {
      pattern = "*",
      command="if &nu | set nornu | endif"
    }
  },
  {
    "BufWritePost",
    {
      pattern = { "bm-files", "bm-dirs" },
      command = "!shortcuts"
    }
  },
  {
    { "BufRead", "BufNewFile" },
    {
      pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
      command = "set filetype=xdefaults"
    }
  },
  {
    "BufWritePost",
    {
      pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
      command = "!xrdb %"
    }
  },
  {
    "BufWritePost",
    {
      pattern = "~/.local/src/dwmblocks/config.h",
      command = "!cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }"
    }
  },
  {
    "BufWritePost",
    {
      pattern = "*.java",
      callback = function()
        vim.lsp.codelens.refresh()
      end
    }
  },
  {
    { "BufDelete", "VimLeave" },
    {
      pattern = "*.tex",
      command = "!texclear \"%:p\""
    }
  },
  { -- Use 'q' to quit from common plugins
    'FileType',
    {
      pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
      callback = function()
        vim.cmd [[
          nnoremap <silent> <buffer> q :close<CR> 
          set nobuflisted 
        ]]
      end
    }
  },
  {
    'Filetype',
    {
      pattern = { "gitcommit", "markdown" },
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
      end,
    }
  },
  { -- Automatically apply changes to plugins.lua
    'BufWritePost',
    {
      group = 'packer_user_config',
      pattern = { "plugins.lua", "pluginlist.lua" },
      command = "source <afile> | PackerCompile"
    }
  },
  { -- Fix auto comment
    'BufWinEnter',
    {
      callback = function()
        vim.cmd("set formatoptions-=cro")
      end
    }
  },
  { -- Highlight yanked text
    'TextYankPost',
    {
      callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
      end
    }
  }
}
