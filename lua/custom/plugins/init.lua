-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Show diagnostics in a float for the current line
vim.keymap.set('n', '<leader>ie', vim.diagnostic.open_float, {
  desc = 'Show line diagnostics',
})

-- Close all other buffers
vim.keymap.set('n', '<leader>bo', function()
  local curr = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= curr then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = 'Close all other buffers' })

-- Create new empty json buffer
vim.keymap.set('n', '<leader>sjson', function()
  vim.cmd 'enew' -- new empty buffer
  vim.bo.filetype = 'json' -- set json filetype
  vim.bo.buftype = 'nofile' -- no file backing
  vim.bo.bufhidden = 'wipe' -- wipe when abandoned
  vim.bo.swapfile = false -- no swapfile
end, { desc = 'New temp JSON buffer' })

-- Create new empty js buffer
vim.keymap.set('n', '<leader>sjs', function()
  vim.cmd 'enew' -- new empty buffer
  vim.bo.filetype = 'js' -- set json filetype
  vim.bo.buftype = 'nofile' -- no file backing
  vim.bo.bufhidden = 'wipe' -- wipe when abandoned
  vim.bo.swapfile = false -- no swapfile
end, { desc = 'New temp JSON buffer' })

return {}
