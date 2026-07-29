-- Reload buffers when their file changes on disk (Claude Code, Codex, git checkout, ...).
--
-- 'autoread' is already on by default, but it only takes effect when Neovim actually
-- compares timestamps. Per `:help timestamp` that happens after a shell command and,
-- in the GUI only, on regaining focus -- so in the TUI a stale buffer stays stale.
-- These autocmds run `:checktime` at the moments a change is likely.
-- The mode() guard is because `:checktime` is not allowed while the command line is active.

vim.o.autoread = true

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = '*',
})

-- The events above only fire on interaction. Sitting still while an agent edits in
-- the next pane fires none of them, so poll as a fallback. Plain normal mode only:
-- a reload prompt mid-insert would interrupt typing.
local timer = assert(vim.uv.new_timer())
timer:start(
  2000,
  2000,
  vim.schedule_wrap(function()
    if vim.fn.mode() == 'n' and vim.fn.getcmdwintype() == '' then pcall(vim.cmd.checktime) end
  end)
)

-- Reloads are silent; say which file just changed under us.
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  callback = function(ev) vim.notify('Reloaded from disk: ' .. vim.fn.fnamemodify(ev.file, ':~:.'), vim.log.levels.INFO) end,
})
