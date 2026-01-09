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
    ];
    script = ''
      set -e
      rsync -av --chmod=0644 "${self}/" /etc/nixos/;
    '';
  };
}
