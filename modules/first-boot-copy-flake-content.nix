{
  self,
  pkgs,
  ...
}: {
  systemd.services.first-boot-copy-flake-content = {
    description = "Copy original configuraton to target image";
    wantedBy = ["default.target"];
    unitConfig = {
      ConditionFirstBoot = "yes";
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    restartIfChanged = false;
    path = [
      pkgs.rsync
      pkgs.busybox
      pkgs.cloud-init
    ];
    script = ''
      set -e
      if cloud-init status --wait | grep -q "status: done"; then
        rsync -av --chmod=0644 "${self}/" /etc/nixos/;
        sed "s/nixos-digital-ocean/$(hostname)/" "${self}/flake.nix" > /etc/nixos/flake.nix;
      fi
    '';
  };
}
