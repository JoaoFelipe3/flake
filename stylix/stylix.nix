# Shared Stylix settings

{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;

    base16Scheme = ./colors.yaml;
    polarity = "dark";

    fonts = {
      monospace = {
        #package = pkgs.nerd-fonts.fantasque-sans-mono;
        #name = "FantasqueSansM Nerd Font Mono";
        name = "MxPlusIBMVGA9x16 Nerd Font Mono";
      };
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        #package = pkgs.nerd-fonts.fantasque-sans-mono;
        #name = "FantasqueSansM Nerd Font";
        name = "MxPlusIBMVGA9x16 Nerd Font";
      };
    };
  };

  specialisation.light.configuration = {
    stylix = {
      base16Scheme = pkgs.lib.mkForce ./colors-light.yaml;
      polarity = pkgs.lib.mkForce "light";
    };
  };
}
