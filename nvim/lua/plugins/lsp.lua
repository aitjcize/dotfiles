local function setup_lspconfig()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('*', { capabilities = capabilities })

  vim.lsp.enable({ 'gopls', 'pyright', 'clangd', 'lua_ls' })

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
  })
end

local function setup_cmp()
  local cmp = require('cmp')

  -- ref: https://github.com/hrsh7th/nvim-cmp
  cmp.setup {
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
      ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    },
  }
end

return {
  {
    'neovim/nvim-lspconfig',
    config = setup_lspconfig,
    dependencies = {
      {
        'hrsh7th/nvim-cmp',
        config = setup_cmp,
      },
      'hrsh7th/cmp-nvim-lsp',
      {
        'folke/neodev.nvim',
        opts = {
          library = {
            -- this is must faster.
            --plugins = false,
            -- you can also specify the list of plugins to make available as a workspace library
            plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
          },
        },
      },
    },
  }
}
