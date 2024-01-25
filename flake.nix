{
  description = "mmuldo's neo(nix)vim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixvim, ... }:
  let
    system = "x86_64-linux";
    config = {
      colorschemes.catppuccin.enable = true;
    };
    nvim = nixvim.legacyPackages."${system}".makeNixvim config;
  in
  {
    packages.x86_64-linux = {
      inherit nvim;
      default = nvim;
    };
  };
}
