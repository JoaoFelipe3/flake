{ config, pkgs, ... }:

{
  xdg.configFile."OpenRGB".source = ./OpenRGB;

  systemd.user.services.set-openrgb-profile = {
    Unit = {
      Description = "Set OpenRGB profile";
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = "${pkgs.writeShellScript "load-openrgb" ''
        ${pkgs.openrgb-with-all-plugins}/bin/openrgb --profile "pinkish"
      ''}";
    };
  };
}
