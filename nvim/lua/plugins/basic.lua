return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  'preservim/nerdcommenter',

  'tpope/vim-fugitive',

  'dhruvasagar/vim-table-mode',

  {
    'airblade/vim-gitgutter',
    config = function()
      vim.opt.updatetime = 100
      vim.opt.signcolumn = 'yes'
    end
  },

  'taxilian/a.vim',

  'junegunn/fzf',
  {
    'junegunn/fzf.vim',
    config = function()
      local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
      local result = handle:read("*a")
      handle:close()

      -- Trim whitespace from result for accurate comparison
      result = string.gsub(result, "^%s*(.-)%s*$", "%1")

      if result == "true" then
        vim.keymap.set('n', '<C-p>', ':GFiles<CR>', {noremap = true, silent = true})
      else
        vim.keymap.set('n', '<C-p>', ':Files<CR>', {noremap = true, silent = true})
      end

    end
  },

  'williamboman/mason.nvim',
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'c', 'cpp', 'python', 'go', 'java' },
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      }
    end
  },

  'github/copilot.vim',
}
