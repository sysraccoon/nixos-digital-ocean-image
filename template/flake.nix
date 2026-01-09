{
  description = "Digital Ocean NixOS Image";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = inputs @ {nixpkgs, ...}: {
    nixosConfigurations = {
      nixos-digital-ocean = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./configuration.nix];
        specialArgs = inputs;
      };
    };
  };
}
