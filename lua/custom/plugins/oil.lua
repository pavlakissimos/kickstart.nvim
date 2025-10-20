-- Neovim file explorer: edit your filesystem like a buffer
return {
  'stevearc/oil.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  lazy = false,
  config = function()
    require('oil').setup {
      view_options = {
        show_hidden = true,
        is_tree = true,
        use_indicator = true,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0,
        max_height = 0,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = 'auto',
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    }

    -- Go up one level
    vim.keymap.set('n', '-', require('oil').open_float, {
      desc = 'Oil: Open parent directory',
    })

    -- Open current file’s dir
    vim.keymap.set('n', '<leader>o', function()
      require('oil').open(vim.fn.expand '%:p:h')
    end, { desc = 'Oil: Open current file’s directory' })

    -- Toggle a side-split Oil pane
    vim.keymap.set('n', '<leader>e', function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'filetype') == 'oil' then
          return vim.api.nvim_win_close(win, false)
        end
      end
      vim.cmd 'leftabove vertical split'
      require('oil').open()
    end, { desc = 'Oil: Toggle in left split' })
  end,
}
