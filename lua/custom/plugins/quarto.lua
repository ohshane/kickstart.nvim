-- quarto

vim.pack.add {
  {
    src = 'https://github.com/quarto-dev/quarto-nvim',
    version = vim.version.range '2.*',
  },
  'https://github.com/jmbuhr/otter.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
}

require('quarto').setup {
  debug = false,
  closePreviewOnExit = true,
  lspFeatures = {
    enabled = true,
    chunks = 'curly',
    languages = { 'r', 'python', 'julia', 'bash', 'html' },
    diagnostics = {
      enabled = true,
      triggers = { 'BufWritePost' },
    },
    completion = {
      enabled = true,
    },
  },
  codeRunner = {
    enabled = true,
    default_method = 'slime', -- "molten", "slime", "iron" or <function>
    ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
    -- Takes precedence over `default_method`
    never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
  },
}

