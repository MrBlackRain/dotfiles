local language_config = require "custom.languages.python.config"

local config = require "plugins.configs.lspconfig"

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require "lspconfig"

for _, value in ipairs(language_config.lsp) do
  lspconfig[value].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" },
  })
end
