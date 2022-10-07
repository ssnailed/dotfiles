autocmds = {
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
    "FileType",
    {
      pattern = "zsh",
      callback = function()
        require("nvim-treesitter.highlight").attach(0, "bash")
      end
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
  { -- Remove statusline and tabline when in Alpha
    'User',
    {
      pattern = { "AlphaReady" },
      callback = function()
        vim.cmd [[
          set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
          set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]]
      end,
    }
  },
  { -- Automatically apply changes to plugins.lua
    'BufWritePost',
    {
      group = 'packer_user_config',
      pattern = "plugins.lua",
      command = "source <afile> | PackerCompile"
    }
  }
}

vim.api.nvim_create_augroup('packer_user_config', {clear = true})

for _, entry in ipairs(autocmds) do
  local event = entry[1]
  local opts = entry[2]
  if type(opts.group) == "string" and opts.group ~= "" then
    local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
    if not exists then
      vim.api.nvim_create_augroup(opts.group, {})
    end
  end
  vim.api.nvim_create_autocmd(event, opts)
end
