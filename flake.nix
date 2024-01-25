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
    nixvimConfig = {
      colorschemes.catppuccin.enable = true;
    };
    nvimModule = { ... }: {
      imports = [
        nixvim.nixosModules.nixvim
      ];
      programs.nixvim = {
        enable = true;
      } // nixvimConfig;
    };
    nvim = nixvim.legacyPackages."${system}".makeNixvim nixvimConfig;
  in
  {
    packages.x86_64-linux = {
      inherit nvim;
      default = nvim;
    };

    nixosModules = {
      nvim = nvimModule;
      default = nvimModule;
    };
  };
}
