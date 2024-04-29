-- function ColorMyPencils(color)
--   color = color or 'rose-pine'
--   vim.cmd.colorscheme(color)
--
--   vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
--   vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
-- end

return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,

    -- config = function()
    --   require('tokyonight').setup {
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     style = 'storm', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    --     transparent = true, -- Enable this to disable setting the background color
    --     terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    --     styles = {
    --       -- Style to be applied to different syntax groups
    --       -- Value is any valid attr-list value for `:help nvim_set_hl`
    --       comments = { italic = false },
    --       keywords = { italic = false },
    --       -- Background styles. Can be "dark", "transparent" or "normal"
    --       sidebars = 'dark', -- style for sidebars, see below
    --       floats = 'dark', -- style for floating windows
    --     },
    --   }
    -- end,
  },

  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --
  --   config = function()
  --     require('catppuccin').setup {
  --       flavour = 'mocha', -- latte, frappe, macchiato, mocha
  --
  --       transparent_background = false, -- disables setting the background color.
  --       show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  --       term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  --
  --       dim_inactive = {
  --         enabled = true, -- dims the background color of inactive window
  --         shade = 'dark',
  --         percentage = 0.15, -- percentage of the shade to apply to the inactive window
  --       },
  --
  --       no_italic = true, -- Force no italic
  --       no_bold = true, -- Force no bold
  --       no_underline = true, -- Force no underline
  --
  --       styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
  --         comments = { 'italic' }, -- Change the style of comments
  --         conditionals = { 'italic' },
  --         loops = {},
  --         functions = {},
  --         keywords = {},
  --         strings = {},
  --         variables = {},
  --         numbers = {},
  --         booleans = {},
  --         properties = {},
  --         types = {},
  --         operators = {},
  --         -- miscs = {}, -- Uncomment to turn off hard-coded styles
  --       },
  --
  --       color_overrides = {},
  --       custom_highlights = {},
  --       default_integrations = true,
  --
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         nvimtree = true,
  --         treesitter = true,
  --         notify = false,
  --         mini = {
  --           enabled = true,
  --           indentscope_color = '',
  --         },
  --         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  --       },
  --     }
  --
  --     -- Setup must be called before loading
  --     vim.cmd.colorscheme 'catppuccin'
  --
  --     -- ColorMyPencils 'catppuccin'
  --   end,
  -- },
}
