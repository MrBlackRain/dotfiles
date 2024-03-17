local utils = require "custom.utils"

local pyright_lsp = "pyright"
local ruff_lsp = "ruff_lsp"

-- cos name for ruff is different for mason and lspconfig
local mason_lsp = { pyright_lsp, "ruff" }
local debugger = "debugpy"

local linters = { "mypy" }
local additional_deps = {}

local mason_deps = {}

vim.list_extend(mason_deps, mason_lsp)
vim.list_extend(mason_deps, { debugger })

vim.list_extend(mason_deps, linters)
vim.list_extend(mason_deps, additional_deps)

local ts_deps = {
  "python",
}

-- TODO: make table merge separate function
-- TODO: make a function for generating this return table (cos probably will be more languages)
return {
  --- specifies name of config field (cos sometimes it's differs from masons lsp name)
  lsp = { pyright_lsp, ruff_lsp },
  linters = linters,
  -- dependencies = utils.merge_arrays({ lsp }, formatters, linters, debugger, additional_deps),
  mason_ensure_installed = mason_deps,
  treesitter_ensure_installed = ts_deps,
}
