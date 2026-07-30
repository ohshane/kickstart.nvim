-- in line commenting

for _, lhs in ipairs { '<C-/>', '<C-_>' } do
  vim.keymap.set('n', lhs, 'gcc', { remap = true, desc = 'Toggle comment line' })
  vim.keymap.set('x', lhs, 'gc', { remap = true, desc = 'Toggle comment selection' })
end
