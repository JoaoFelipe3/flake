{ config, pkgs, inputs, ... }:

{
  programs.plasma = {
    enable = true;

    # hotkeys.commands."launch-ghostty" = {
    #   name = "Launch Ghostty";
    #   key = "Meta+Return";
    #   command = "ghostty";
    # };

    shortcuts = {
      "services\\/com.mitchellh.ghostty.desktop" = {
        "_launch" = "Meta+Return";
      };
    };
  };
}
