{
  nvim-cmp = {
    enable = true;
    snippet.expand = "luasnip";
    mapping = {
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-n>" = {
        action = "cmp.mapping.select_next_item()";
        modes = [ "i" "s" ];
      };
      "<C-p>" = {
        action = "cmp.mapping.select_prev_item()";
        modes = [ "i" "s" ];
      };
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<C-b>" = "cmp.mapping.scroll_docs(-4)";
      "<C-y>" = "cmp.mapping.confirm({ select = true })";
      "<C-e>" = "cmp.mapping.close()";
      "<C-l>" = {
        action = ''cmp.mapping(function(fallback)
          local luasnip = require("luasnip")
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end)'';
        modes = [ "i" "s" ];
      };
      "<C-h>" = {
        action = ''cmp.mapping(function(fallback)
          local luasnip = require("luasnip")
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end)'';
        modes = [ "i" "s" ];
      };
    };
    sources = [
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "buffer"; }
    ];
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
}
