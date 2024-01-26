{
  lsp = {
    enable = true;
    capabilities = "require('cmp_nvim_lsp').default_capabilities()";
    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };
    servers = {
      nixd.enable = true;
      # TODO: rustaceanvim
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };

  # TODO: rustaceanvim
  rust-tools = {
    enable = true;
  };
}
