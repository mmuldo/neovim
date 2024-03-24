{
  plugins = {
    cmp = {
      enable = true;
      settings = {
        snippet.expand = "luasnip";
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
          "<C-e>" = "cmp.mapping.close()";
          "<C-l>" = ''cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, {"i", "s"})'';
          "<C-h>" = ''cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, {"i", "s"})'';
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
        ];
      };
    };

    luasnip = {
      enable = true;
    };

    cmp_luasnip = {
      enable = true;
    };

    friendly-snippets = {
      enable = true;
    };

    cmp-nvim-lsp = {
      enable = true;
    };
  };
}
