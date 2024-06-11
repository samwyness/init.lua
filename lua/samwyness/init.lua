require 'samwyness.set'
require 'samwyness.remap'
require 'samwyness.lazy_init'

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('samwyness-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 100,
    }
  end,
})
