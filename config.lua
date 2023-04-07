--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
vim.opt.spell = true
vim.opt.spelllang = { "en" }
-- vim.g.everforest_background = 'hard'
vim.opt.termguicolors = true

-- lvim.colorscheme = "lunar"
-- lvim.colorscheme = "everforest"
lvim.colorscheme = "catppuccin"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.dap.active = true

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "flutter")
end

lvim.builtin.terminal.direction = "vertical"
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "dart",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- Additional Plugins
lvim.plugins = {

  -- { "rcarriga/nvim-dap-ui" },
  { 'akinsho/flutter-tools.nvim', require = 'nvim-lua/plenary.nvim' },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "rebelot/kanagawa.nvim" },

  { 'sainnhe/everforest' },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    disable = lvim.colorscheme ~= "catppuccin",
    config = function()
      require('catppuccin').setup({
        -- flavor = 'mocha',
        -- flavor = 'all',
        -- flavour = "frappe", -- mocha, macchiato, frappe, latte
        color_overrides = {
          all = {
            base = "#2B2B2B",
            mantle = "#313335",
            crust = "#3D3F41",
            rosewater = "#F2D5CF",
            flamingo = "#EEBEBE",
            pink = "#F4B8E4",
            mauve = "#B8773F",
            red = "#E78284",
            maroon = "#EA999C",
            peach = "#EF9F76",
            yellow = "#F6C87B",
            green = "#70865E",
            teal = "#9377A7",
            sky = "#99D1DB",
            sapphire = "#85C1DC",
            blue = "#8CAAEE",
            lavender = "#BABBF1",
            text = "#ACB7C4",
            subtext1 = "#b5bfe2",
            subtext0 = "#a5adce",
            overlay2 = "#949cbb",
            overlay1 = "#838ba7",
            overlay0 = "#737994",
            surface2 = "#626880",
            surface1 = "#51576d",
            surface0 = "#414559",
          },
        },
        custom_highlights = function(colors)
          return {
            Comment = { fg = colors.green },
            ["@comment"] = { fg = colors.green, style = { "italic" } },
          }
        end
      })
      vim.cmd [[colorscheme catppuccin]]
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-;>",
            accept_word = false,
            accept_line = false,
            next = "<C-.>",
            prev = "<C-,",
            dismiss = "<C-x>",
          },
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  },

}

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.builtin.dap.on_config_done = function(dap)
  dap.defaults.dart.exception_breakpoints = { 'raised' }
  dap.adapters.dart = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/.local/share/nvim/dapinstall/dart-code/out/dist/debug.js", "flutter" },
  }

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch Flutter",
      dartSdkPath = os.getenv("HOME") .. "/Development/flutter/bin/cache/dart-sdk/",
      flutterSdkPath = os.getenv("HOME") .. "/Development/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      type = "dart",
      dartSdkPath = os.getenv("HOME") .. "/Development/flutter/bin/cache/dart-sdk/",
      name = "Flutter Dev",
      request = "launch",
      flutterSdkPath = os.getenv("HOME") .. "/Development/flutter",
      program = "lib/main_dev.dart",
      args = { "--flavor", "dev" },
    },
  }
end

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

require("flutter-tools").setup {
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = true,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = true,
    }
  },
  debugger = {
    -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
    register_configurations = function()
      require("dap").configurations.dart = {
        {
          dartSdkPath = os.getenv("HOME") .. "/Development/flutter/bin/cache/dart-sdk/",
          name = "Flutter Dev",
          request = "launch",
          flutterSdkPath = os.getenv("HOME") .. "/Development/flutter",
          type = "dart",
          program = "lib/main_dev.dart",
          args = { "--flavor", "dev" },
        }
      }
    end
  },
  --flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
  --flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "Comment", -- highlight for the closing tag
    prefix = "^",          -- character to use for close tag e.g. > Widget
    enabled = true         -- set to false to disable
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  dev_tools = {
    autostart = false,         -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false    -- if true this will open the outline automatically when it is first populated
  },
  -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
  settings = {
    showTodos = true,
    completeFunctionCalls = true,
    renameFilesWithClasses = "prompt", -- "always"
    enableSnippets = true,
  }
}
