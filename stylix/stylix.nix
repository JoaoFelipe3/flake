# Shared Stylix settings

{ config, pkgs, inputs, ... }:

with inputs.color-palette; {
  stylix = {
    enable = true;
    autoEnable = false;

    base16Scheme = {
      base00 = builtins.elemAt gray 2;
      base01 = builtins.elemAt gray 3;
      base02 = builtins.elemAt gray 4;
      base03 = builtins.elemAt gray 5;
      base04 = builtins.elemAt gray 7;
      base05 = builtins.elemAt gray 8;
      base06 = builtins.elemAt gray 9;
      base07 = builtins.elemAt gray 10;
      base08 = builtins.elemAt red 1;
      base09 = builtins.elemAt orange 1;
      base0A = builtins.elemAt yellow 1;
      base0B = builtins.elemAt green 1;
      base0C = builtins.elemAt teal 1;
      base0D = builtins.elemAt blue 1;
      base0E = builtins.elemAt purple 1;
      base0F = builtins.elemAt accent 1;
      base10 = builtins.elemAt gray 1;
      base11 = builtins.elemAt gray 0;
      base12 = builtins.elemAt red 2;
      base13 = builtins.elemAt yellow 2;
      base14 = builtins.elemAt green 2;
      base15 = builtins.elemAt teal 2;
      base16 = builtins.elemAt blue 2;
      base17 = builtins.elemAt purple 2;
    };
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "FantasqueSansM Nerd Font Mono";
        #name = "MxPlusIBMVGA9x16 Nerd Font Mono";
      };
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "FantasqueSansM Nerd Font";
        #name = "MxPlusIBMVGA9x16 Nerd Font";
      };
    };
  };
}
