local lspconfig = require "lspconfig"

-- bash
lspconfig.bashls.setup {}

-- Docker
lspconfig.dockerls.setup {}
lspconfig.docker_compose_language_service.setup {}

-- JSON
lspconfig.jsonls.setup {}

-- TOML
lspconfig.taplo.setup {}

-- Markdown
lspconfig.marksman.setup {}

-- yaml
lspconfig.yamlls.setup {}

-- XML
lspconfig.lemminx.setup {}
