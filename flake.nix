{
  description = "Digital Ocean NixOS Image";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    template.url = "path:./template";
  };

  outputs = {
    template,
    ...
  }: let
    system = "x86_64-linux";
    nixosDigitalOceanConfig = template.outputs.nixosConfigurations.nixos-digital-ocean;
    nixosDigitalOceanImage = (nixosDigitalOceanConfig.extendModules {
      modules = [
        ./modules/digital-ocean-image.nix
        ./modules/first-boot-copy-flake-content.nix
      ];
    }).config.system.build.image;
  in {
    packages.${system}.default = nixosDigitalOceanImage;
  };
}
