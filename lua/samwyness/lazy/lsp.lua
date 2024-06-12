return {
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'filipdutescu/renamer.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'j-hui/fidget.nvim',
      'filipdutescu/renamer.nvim',
      {
        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/neodev.nvim',
        opts = {},
      },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', {}, capabilities, require('cmp_nvim_lsp').default_capabilities())

      local lspconfig = require 'lspconfig'

      local inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      }

      lspconfig.tsserver.setup {
        capabilities = capabilities,
        settings = {
          completion = {
            completeFunctionCalls = true,
          },
          javascript = {
            inlayHints = inlayHints,
          },
          typescript = {
            inlayHints = inlayHints,
          },
        },
      }

      lspconfig.eslint.setup {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end,
      }

      lspconfig.gopls.setup {
        capabilities = capabilities,
      }

      lspconfig.html.setup {
        capabilities = capabilities,
      }

      -- lspconfig.stylua.setup {
      --   capabilities = capabilities,
      -- }

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            hint = { enable = true },
          },
        },
      }

      -- Add keymaps when lsp is attached to the buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('samwyness-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          map('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('<leader>gr', vim.lsp.buf.references, '[G]oto [R]eferences')
          map('<leader>rn', '<cmd>lua require("renamer").rename()<cr>', '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ctions')
          
          -- Typescript specific code actions
          map('<leader>co', function()
            vim.lsp.buf.code_action {
              apply = true,
              context = {
                only = { 'source.organizeImports.ts' },
                diagnostics = {},
              },
            }
          end, '[C]ode [O]rganize imports')

          map('<leader>cr', function()
            vim.lsp.buf.code_action {
              apply = true,
              context = {
                only = { 'source.removeUnused.ts' },
                diagnostics = {},
              },
            }
          end, '[C]ode [R]emove unused imports')

          local telescopeBuiltin = require 'telescope.builtin'
          map('<leader>gI', telescopeBuiltin.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', telescopeBuiltin.lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', telescopeBuiltin.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', telescopeBuiltin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          map('<leader>h', function()
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(nil), nil)
          end, 'Toggle Inlay [H]ints')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Make diagnostics look better
      vim.diagnostic.config {
        float = {
          focusable = true,
          source = true,
          style = 'minimal',
          border = 'double',
        },
      }
    end,
  },
}
