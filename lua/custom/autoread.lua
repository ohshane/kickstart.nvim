-- Reload buffers when their file changes on disk (Claude Code, Codex, git checkout, ...).
--
-- 'autoread' is already on by default, but it only takes effect when Neovim actually
-- compares timestamps. Per `:help timestamp` that happens after a shell command and,
-- in the GUI only, on regaining focus -- so in the TUI a stale buffer stays stale.
-- These autocmds run `:checktime` at the moments a change is likely.
-- The mode() guard is because `:checktime` is not allowed while the command line is active.

vim.o.autoread = true

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = '*',
})
