return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',

  dependencies = {
    'windwp/nvim-ts-autotag',
  },

  opts = {
    ensure_installed = {
      'c',
      'bash',
      'json',
      'yaml',
      'html',
      'css',
      'jsdoc',
      'javascript',
      'typescript',
      'tsx',
      'graphql',
      'gitignore',
      'dockerfile',
      'lua',
      'markdown',
      'vim',
      'vimdoc',
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Autoinstall languages that are not installed
    auto_install = true,

    highlight = {
      enable = true,

      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },

    autotag = { enable = true },
  },

  config = function(_, opts)
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
