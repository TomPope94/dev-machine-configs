local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'eslint',
    'html',
    'cssls',
    'pyright',
    'pylsp'
  },
  handlers = {
    function(server)
      lspconfig[server].setup({})
    end,
    ['ts_ls'] = function()
      lspconfig.ts_ls.setup({
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        }
      })
    end,
    ['pylsp'] = function()
      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = false },
              flake8 = {
                enabled = true,
                maxLineLength = 150
              },
              pylint = { enabled = false }
            }
          }
        }
      })
    end,
    ['eslint'] = function()
      lspconfig.eslint.setup({
        settings = {
          format = { enable = true }
        }
      })
    end
  }
})
