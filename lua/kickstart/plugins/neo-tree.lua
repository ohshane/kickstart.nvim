-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

-- Refresh git status in the tree when coming back from another tmux pane or a
-- terminal; an agent or a git command may have changed things meanwhile.
-- (use_libuv_file_watcher below only covers file creation/deletion, not git state.)
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermLeave' }, {
  callback = function()
    local ok, events = pcall(require, 'neo-tree.events')
    if ok then events.fire_event(events.GIT_EVENT) end
  end,
})

require('neo-tree').setup {
  filesystem = {
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}
