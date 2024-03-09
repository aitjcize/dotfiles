return {
  {
    'chriskempson/vim-tomorrow-theme',
    name = 'vim-tomorrow-theme',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'Tomorrow-Night'
    end
  }
}
