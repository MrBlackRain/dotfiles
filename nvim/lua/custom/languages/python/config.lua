local utils = require "custom.utils"

local lsp_name = "pyright"

local lsp = lsp_name
local debugger = "debugpy"

local formatters = { "black", "isort" }
local linters = { "ruff", "mypy" }
local additional_deps = {}

local mason_deps = {}

vim.list_extend(mason_deps, { lsp })
vim.list_extend(mason_deps, { debugger })

vim.list_extend(mason_deps, formatters)
vim.list_extend(mason_deps, linters)
vim.list_extend(mason_deps, additional_deps)

local ts_deps = {
  "python",
}

-- TODO: make table merge separate function
-- TODO: make a function for generating this return table (cos probably will be more languages)
return {
  --- specifies name of config field (cos sometimes it's differs from masons lsp name)
  lsp = lsp_name,
  formatters = formatters,
  linters = linters,
  -- dependencies = utils.merge_arrays({ lsp }, formatters, linters, debugger, additional_deps),
  mason_ensure_installed = mason_deps,
  treesitter_ensure_installed = ts_deps,
}
