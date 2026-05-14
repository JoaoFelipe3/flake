# Shared Stylix settings

{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = ./colors.yaml;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "FantasqueSansM Nerd Font Mono";
      };
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "FantasqueSansM Nerd Font";
      };
    };
  };
}
