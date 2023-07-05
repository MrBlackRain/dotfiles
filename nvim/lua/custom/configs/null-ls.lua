local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local python_tools = require "custom.languages.python.tools"
local ts_tools = require "custom.languages.typescript.tools"

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.taplo,
}

vim.list_extend(sources, python_tools)
vim.list_extend(sources, ts_tools)

local opts = {
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

return opts
