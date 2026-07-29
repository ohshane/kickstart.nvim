-- Diffview: review a whole changeset in one view -- the main way to inspect
-- what an agent just edited before asking for follow-ups.
-- https://github.com/sindrets/diffview.nvim

vim.pack.add {
  'https://github.com/sindrets/diffview.nvim',
}

require('diffview').setup()

require('which-key').add { { '<leader>g', group = '[G]it diff' } }

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = '[G]it [D]iff working tree' })
vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<CR>', { desc = '[G]it diff [Q]uit' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = '[G]it file [H]istory' })
