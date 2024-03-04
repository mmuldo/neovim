{
  plugins.none-ls = {
    enable = true;
    sources = {
      code_actions = {
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
      };
      formatting = {
        nixfmt.enable = true;
      };
    };
  };
}
