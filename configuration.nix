{
  pkgs,
  ...
}: {
  imports = [
    ./digital-ocean-specific.nix
  ];

  system.stateVersion = "25.11";

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  nix = {
    settings = {
      tarball-ttl = 300;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
}
