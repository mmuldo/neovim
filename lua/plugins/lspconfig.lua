return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },

      -- use a release tag to download pre-built binaries
      version = "1.*",

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = "default" },
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        completion = {
          trigger = {
            show_on_trigger_character = true,
          },
        },
      },

      opts_extend = { "sources.default" },
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          "lazy.nvim",
        },
      },
    },
  },
  config = function()
    local hostname = vim.uv.os_gethostname()
    local flake_dir = DirExists(vim.fn.expand("~/flakes/nixos")) and "~/flakes/nixos" or ("~/flakes/" .. hostname)
    local nixos_flake = string.format('(builtins.getFlake ("git+file://" + toString %s))', flake_dir)
    local nixos_options = string.format("%s.nixosConfigurations.%s.options", nixos_flake, hostname)
    local servers = {
      lua_ls = {},
      nixd = {
        cmd = { "nixd" },
        settings = {
          nixpkgs = {
            expr = string.format("import %s.inputs.nixpkgs { }", nixos_flake),
          },
          formatting = {
            command = { "nixfmt" },
          },
          options = {
            nixos = {
              expr = nixos_options,
            },
            home_manager = {
              expr = string.format("%s.home-manager.users.type.getSubOptions []", nixos_options),
            },
          },
        },
        offset_encoding = "utf-8",
      },
    }

    for server, config in pairs(servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities or {})
      require("lspconfig")[server].setup(config)
    end

    vim.diagnostic.config({ virtual_text = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
      callback = function(e)
        local client = assert(vim.lsp.get_client_by_id(e.data.client_id), "must have valid lsp clien")
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end

        local keymap = function(keys, func)
          vim.keymap.set("n", keys, func, { buffer = e.buf })
        end
        local fzf = require("fzf-lua")

        keymap("gd", fzf.lsp_definitions)
        keymap("gD", fzf.lsp_declarations)
        keymap("gr", fzf.lsp_references)
        keymap("gI", fzf.lsp_implementations)
        keymap("<leader>d", fzf.diagnostics_workspace)
        keymap("<leader>D", fzf.lsp_typedefs)
        keymap("<leader>rn", vim.lsp.buf.rename)
        keymap("<leader>ca", vim.lsp.buf.code_action)
        keymap("<leader>bf", vim.lsp.buf.format)
        keymap("K", vim.lsp.buf.hover)
        keymap("<leader>e", vim.diagnostic.open_float)
      end,
    })
  end,
}
