return {
  {
    'nvim-neotest/neotest',

    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-jest',
    },

    config = function()
      require('neotest').setup {
        log_level = vim.log.levels.WARN,
        -- discovery = {
        --   enabled = true,
        --   concurrent = 1,
        -- },
        adapters = {
          require 'neotest-plenary',
          require 'neotest-jest' {
            -- jest_test_discovery = true,
            jestConfigFile = 'jest.config.js',
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,

    keys = {
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run [F]ile',
      },
      {
        '<leader>tA',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = 'Run [A]ll Test Files',
      },
      {
        '<leader>tr',
        function()
          require('neotest').run.run()
        end,
        desc = '[R]un Nearest',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Run [L]ast',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle [S]ummary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Show [O]utput',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle [O]utput Panel',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = '[S]top Test',
      },
      {
        '<leader>tw',
        function()
          require('neotest').watch.toggle(vim.fn.expand '%')
        end,
        desc = 'Toggle [W]atch',
      },
    },
  },
}
