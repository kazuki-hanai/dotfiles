return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
    },
    config = function()
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or 'single'
        opts.max_width= opts.max_width or math.floor(vim.fn.winwidth(0) * 0.7)
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup {
          settings = {
              Lua = {
                  diagnostics = {
                      globals = { 'vim' }
                  }
              }
          }
      }
      lspconfig.clangd.setup {}
      lspconfig.pylyzer.setup{}
      lspconfig.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = false;
            }
          }
        }
      }
      lspconfig.gopls.setup {}
      lspconfig.tsserver.setup {}
      lspconfig.denols.setup {}
      lspconfig.yamlls.setup {
        settings = {
          yaml = {
            trace = {
              server = "verbose"
            },
            schemas = require("schemastore").yaml.schemas(),
            schemaDownload = {  enable = true },
            validate = true,
          }
        },
      }
      lspconfig.terraformls.setup {}
      lspconfig.dagger.setup {}
      lspconfig.graphql.setup {}
      -- lspconfig.markdownlint.setup {}
      lspconfig.tailwindcss.setup {}
      -- lspconfig.prettier.setup {}
    end
  }
}
