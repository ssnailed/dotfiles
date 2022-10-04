return {
  {
    { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
    {
      pattern = "*",
      command="if &nu && mode() != \"i\" | set rnu   | endif"
    }
  },
  {
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
    "ColorScheme",
    {
      pattern = "*",
      command = "hi FloatermBorder guibg=none"
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
  {
    'BufWritePost',
    {
      group = 'packer_user_config',
      pattern = "plugins.lua",
      command = "source <afile> | PackerCompile"
    }
  }
}
