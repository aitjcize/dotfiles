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
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'lua', 'vim', 'vimdoc', 'c', 'cpp', 'python', 'go', 'java',
        'markdown', 'markdown_inline',
      }
      -- Filetypes to enable treesitter highlighting for (vimdoc -> 'help',
      -- markdown_inline is injected by markdown).
      local filetypes = {
        'lua', 'vim', 'help', 'c', 'cpp', 'python', 'go', 'java', 'markdown',
      }

      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath('data') .. '/site',
      }
      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function(args)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > max_filesize then
            return
          end
          vim.treesitter.start(args.buf)
        end,
      })
    end
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {},
  },

  'github/copilot.vim',
}
