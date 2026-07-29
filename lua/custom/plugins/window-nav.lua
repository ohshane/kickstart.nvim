-- Move focus between Neovim windows with C-hjkl, falling through to the
-- neighbouring tmux pane when there is no window left in that direction.
--
-- The tmux side must forward C-hjkl to nvim panes instead of acting on them
-- itself; see the `is_vim` block in ~/.tmux.conf.

local M = {}

local tmux_flag = { h = 'L', j = 'D', k = 'U', l = 'R' }
local label = { h = 'left', j = 'lower', k = 'upper', l = 'right' }

--- Focus the window in `dir` ('h', 'j', 'k' or 'l'), or the tmux pane that way
--- if the current window is already at the edge.
---@param dir string
---@return function
function M.move(dir)
  return function()
    local before = vim.api.nvim_get_current_win()
    vim.cmd.wincmd(dir)
    if before ~= vim.api.nvim_get_current_win() or not vim.env.TMUX then return end
    -- Stay put in a zoomed pane; a bare select-pane would make tmux drop the zoom.
    vim.system {
      'tmux',
      'if',
      '-F',
      '#{?window_zoomed_flag,0,1}',
      ('select-pane -t %s -%s'):format(vim.env.TMUX_PANE, tmux_flag[dir]),
    }
  end
end

--- Map C-hjkl to M.move in `modes`. Extra `opts` go to vim.keymap.set, so pass
--- `{ buffer = n }` to scope the mappings to a single buffer.
---@param modes string|string[]
---@param opts table|nil
function M.map(modes, opts)
  for dir, name in pairs(label) do
    local o = vim.tbl_extend('force', { desc = 'Move focus to the ' .. name .. ' window/pane' }, opts or {})
    vim.keymap.set(modes, '<C-' .. dir .. '>', M.move(dir), o)
  end
end

-- Normal mode only: terminal buffers keep their native C-hjkl, and tmux's
-- `is_vim` check already handles panes running other programs.
M.map 'n'

return M
