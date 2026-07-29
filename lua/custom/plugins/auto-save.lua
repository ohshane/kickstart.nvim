-- auto-save
-- https://github.com/okuuva/auto-save.nvim

vim.pack.add {
  {
    src = 'https://github.com/okuuva/auto-save.nvim',
    version = vim.version.range '1.*',
  },
}

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>ASToggle<CR>', {
  desc = '[A]uto save',
})

local group = vim.api.nvim_create_augroup('autosave', {})

vim.api.nvim_create_autocmd('User', {
  pattern = 'AutoSaveEnable',
  group = group,
  callback = function() vim.notify('AutoSave enabled', vim.log.levels.INFO) end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'AutoSaveDisable',
  group = group,
  callback = function() vim.notify('AutoSave disabled', vim.log.levels.INFO) end,
})

require('auto-save').setup {
  -- your config goes here
  -- or just leave it empty :)
  enabled = true,
  -- Only save real files. Plugin buffers set a non-empty 'buftype' and often
  -- hook BufWriteCmd for their own purposes -- e.g. harpoon's quick menu is
  -- an `acwrite` buffer whose BufWriteCmd closes the menu, so an autosave
  -- would make it vanish about a second after opening.
  condition = function(buf) return vim.bo[buf].buftype == '' end,
}
