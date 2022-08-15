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
}
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.dart = {
    type = "executable",
    command = "node",
    args = { "/Users/ahrar/Dart-Code/out/dist/debug.js", "flutter" }
  }
  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = "/Users/ahrar/Development/flutter/bin/cache/dart-sdk/",
      flutterSdkPath = "/Users/ahrar/Development/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      dartSdkPath = "/Users/ahrar/Development/flutter/bin/cache/dart-sdk/",
      name = "Flutter Dev",
      request = "launch",
      flutterSdkPath = "/Users/ahrar/Development/flutter",
      type = "dart",
      program = "${workspaceFolder}/lib/main_dev.dart",
      args = { "--flavor", "dev" },
      cmd = "${workspaceFolder}"
    }

  }

end
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
    register_configurations = function(paths)
      lvim.dap.configurations.dart = {
        {
          dartSdkPath = "/Users/ahrar/Development/flutter/bin/cache/dart-sdk/",
          name = "Flutter Dev",
          request = "launch",
          flutterSdkPath = "/Users/ahrar/Development/flutter",
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
