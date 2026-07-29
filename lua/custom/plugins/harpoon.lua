-- harpoon
-- https://github.com/ThePrimeagen/harpoon

vim.pack.add {
  {
    src = 'https://github.com/ThePrimeagen/harpoon',
    version = 'harpoon2',
  },
}

local harpoon = require 'harpoon'
harpoon:setup()

require('which-key').add { { '<leader>n', group = 'Harpoo[n]' } }

vim.keymap.set('n', '<leader>na', function() harpoon:list():add() end, { desc = 'Harpoo[N] [A]dd file' })
vim.keymap.set('n', '<leader>nl', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoo[N] [L]ist files' })

vim.keymap.set('n', '<leader>nh', function() harpoon.ui:toggle_quick_menu(harpoon:list():select(1)) end, { desc = 'Harpoo[N] [H] (First)' })
vim.keymap.set('n', '<leader>nj', function() harpoon.ui:toggle_quick_menu(harpoon:list():select(2)) end, { desc = 'Harpoo[N] [J] (Second)' })
vim.keymap.set('n', '<leader>nk', function() harpoon.ui:toggle_quick_menu(harpoon:list():select(3)) end, { desc = 'Harpoo[N] [K] (Third)' })
