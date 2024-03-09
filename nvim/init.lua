local function basic_config()
  vim.opt.background = 'dark'
  vim.opt.backspace = {'indent', 'eol', 'start'}
  vim.opt.colorcolumn = '81'
  vim.opt.formatoptions = "tcrqj"
  vim.opt.hlsearch = true
  vim.opt.incsearch = true
  vim.opt.listchars = {tab = "»·", trail = "·", eol="$"}
  vim.opt.modeline = true
  vim.opt.cursorline = true
  vim.opt.ruler = true
  vim.opt.showcmd = true
  vim.opt.wildignore:append('*/tmp/*,*.so,*.swp,*.zip,*.pyc')
  vim.opt.mouse = ''

  -- Tabs
  vim.api.nvim_set_keymap('n', 't', ':tabe ', {noremap = true})
  vim.api.nvim_set_keymap('n', '<C-j>', ':tabprevious<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<C-k>', ':tabnext<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('i', '<C-j>', '<ESC>:tabprevious<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('i', '<C-k>', '<ESC>:tabnext<CR>', {noremap = true, silent = true})
end

local function main()
  basic_config()

  require('coding_styles').setup()
  require('plugin').setup()
end

main()
