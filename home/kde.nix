{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.oxygen-sounds
  ];

  programs.plasma = {
    enable = true;
    
    workspace = {
      soundTheme = "Oxygen";
    };

    shortcuts = {
      "services\\/com.mitchellh.ghostty.desktop" = {
        "_launch" = "Meta+Return";
      };
      
      kwin = {
        "Switch to Next Desktop" = "Meta+Ctrl+Right";
        "Switch to Previous Desktop" = "Meta+Ctrl+Left";
      } // builtins.listToAttrs (map (n: {
          name = "Switch to Desktop ${toString n}";
          value = "Meta+${toString n}";
        }
      ) (builtins.genList (x: x + 1) 9))
      // builtins.listToAttrs (map (n: {
          name = "Window to Desktop ${toString n}";
          value = "Meta+Shift+${toString n}";
        }
      ) (builtins.genList (x: x + 1) 9));
    };

    configFile."kwinrc" = {
      Script-polonium = {
        engine = 0;
        maximizeSolo = false;
        borderVisibility = "borderAll";
      };
    };

    kwin.scripts = {
      polonium.enable = true;
    };
  };
}
