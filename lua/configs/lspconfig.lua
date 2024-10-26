-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "biome", "html", "cssls", "tailwindcss", "jsonls", "eslint" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
-- configuring single server, example: typescript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

for _, lsp in ipairs(servers) do
  if lsp == "tailwindcss" then
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
      },
    }
  else
    lspconfig[lsp].setup {
      on_init = nvlsp.on_init,
      on_attach = nvlsp.on_attach,
      capabilities = nvlsp.capabilities,
    }
  end
end
