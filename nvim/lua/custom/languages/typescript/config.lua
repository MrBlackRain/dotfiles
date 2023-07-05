local utils = require "custom.utils"

local lsp_name = "tsserver"

local lsp = "typescript-language-server"
local debugger = "js-debug-adapter"

local formatters = { "prettier" }
local linters = { "eslint-lsp" }
local additional_deps = { "tailwindcss-language-server", "prisma-language-server" }

local mason_deps = {}

vim.list_extend(mason_deps, { lsp })
vim.list_extend(mason_deps, { debugger })

vim.list_extend(mason_deps, formatters)
vim.list_extend(mason_deps, linters)
vim.list_extend(mason_deps, additional_deps)

local ts_deps = {
  "typescript",
  "tsx",
  "prisma",
  "css",
  "html",
  "javascript",
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
