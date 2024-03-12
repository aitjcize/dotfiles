local M = {}

local function set_filetype_format()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      'vim', 'lua', 'c', 'cpp', 'proto', 'cuda', 'sh', 'html', 'eruby', 'htmldjango',
      'javascript', 'typescript', 'typescript.tsx', 'sql', 'scss', 'lex',
      'ruby', 'xml', 'opencl', 'json', 'go', 'python'
    },
    callback = function()
      vim.opt.cindent = true
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.expandtab = true
      vim.opt.textwidth = 80
    end,
  })
end

function M.setup()
  set_filetype_format()
end

return M
