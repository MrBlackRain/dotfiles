local language_config = require "custom.languages.typescript.config"

local config = require "plugins.configs.lspconfig"

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require "lspconfig"

lspconfig[language_config.lsp].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.tailwindcss.setup({})
lspconfig.prismals.setup({})
lspconfig.eslint.setup({})
