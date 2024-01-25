{
  description = "mmuldo's neo(nix)vim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    config = import ./modules { inherit pkgs; };

    package = nixvim.legacyPackages.${system}.makeNixvim config;

    module = { ... }: {
      imports = [
        nixvim.nixosModules.nixvim
      ];
      programs.nixvim = {
        enable = true;
      } // config;
    };
  in
  {
    packages.x86_64-linux = {
      nvim = package;
      default = package;
    };

    nixosModules = {
      neovim = module;
      default = module;
    };
  };
}
