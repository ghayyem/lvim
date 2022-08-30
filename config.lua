-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "everforest"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.dap.active = true
lvim.builtin.telescope.defaults = {
  path_display = { "truncate" },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "flutter")
end
lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.terminal.direction = "horizontal"

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
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.plugins = {
  { 'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim' },
  { 'sainnhe/everforest' },
  { "rcarriga/nvim-dap-ui" },
  { "catppuccin/nvim", as = "catppuccin" },
  { "doums/darcula" },
  { 'mhartington/oceanic-next' },
  { "Mofiqul/dracula.nvim" },
  { 'shaunsingh/nord.nvim' },
  { 'shaunsingh/moonlight.nvim' },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
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
  dap.adapters.dart = {
    type = "executable",
    command = "flutter",
    args = { os.getenv('HOME') .. "/Dart-Code/out/dist/debug.js", "flutter" }
  }
  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = os.getenv('HOME') .. "/Development/flutter/bin/cache/dart-sdk/",
      flutterSdkPath = os.getenv('HOME') .. "/Development/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      dartSdkPath = os.getenv('HOME') .. "/Development/flutter/bin/cache/dart-sdk/",
      flutterSdkPath = os.getenv('HOME') .. "/Development/flutter",
      name = "Flutter Dev",
      request = "launch",
      type = "dart",
      program = "${workspaceFolder}/lib/main_dev.dart",
      args = { "--flavor", "dev" },
      cmd = "${workspaceFolder}"
    }

  }
end

require("dapui").setup()

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
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
    register_configurations = function()
      require("dap").configurations.dart = {
        {
          dartSdkPath = os.getenv('Home') .. "/Development/flutter/bin/cache/dart-sdk/",
          name = "Flutter Dev",
          request = "launch",
          flutterSdkPath = os.getenv('Home') .. "/Development/flutter",
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
    prefix = "^", -- character to use for close tag e.g. > Widget
    enabled = true -- set to false to disable
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  dev_tools = {
    autostart = false, -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false -- if true this will open the outline automatically when it is first populated
  },
  -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
  settings = {
    showTodos = true,
    completeFunctionCalls = true,
    renameFilesWithClasses = "prompt", -- "always"
    enableSnippets = true,
  }
}
