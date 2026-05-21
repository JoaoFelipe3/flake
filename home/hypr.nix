{ config, pkgs, inputs, ... }:

let
  hyprbars = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars;
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    plugins = [
      hyprbars
    ];

    settings = with config.lib.stylix.colors; {
      monitor = [
        "HDMI-A-1, 1440x900@60, 1920x0, 1"
        "DP-1, 1920x1080@180, 0x0, 1"
      ];

      "$terminal" = "wezterm";
      "$fileManager" = "thunar";
      "$menu" = "hyprlauncher";
      "$mainMod" = "SUPER";

      exec-once = [
        "waybar"
        "systemctl --user import-environment WAYLAND_DISPLAY"
        "ibus start --type wayland"
        "wezterm start -- nu -e 'fastfetch; systemd-analyze'"
        "systemctl --user start hyprpolkitagent"
        "hyprpaper"
        "[workspace special:music silent] sh -c 'while true; do wezterm start -- rmpc; done'"
        "hyprctl plugin load '${hyprbars}/lib/libhyprbars.so'"
      ];

      general = {
        gaps_in = 8;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(${base05})";
        "col.inactive_border" = "rgb(${base03})";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 4;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 1;
          color = "rgba(${base00}20)";
          offset = "10, 10";
        };
        blur = {
          enabled = false;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      plugin = {
        hyprbars = {
          bar_height = 25;
          bar_color = "rgb(${base01})";
          "col.text" = "rgb(${base05})";
          bar_text_size = 12;
          bar_text_font = "${config.stylix.fonts.sansSerif.name}";
          bar_buttons_alignment = "right";

          hyprbars-button = [
            "rgb(${base08}), 16, , hyprctl dispatch killactive"
          ]; 
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
          "easeInQuint,    0.64, 0,    0.78, 0"
        ];
        animation = [
          "global,              1, 10,   default"
          "border,              1, 5.39, easeOutQuint"
          "windows,             1, 4.79, easeOutQuint"
          "windowsIn,           1, 4.1,  easeOutQuint, popin 87%"
          "windowsOut,          1, 1.49, linear,       popin 87%"
          "fadeIn,              1, 1.73, almostLinear"
          "fadeOut,             1, 1.46, almostLinear"
          "fade,                1, 3.03, quick"
          "layers,              1, 3.81, easeOutQuint"
          "layersIn,            1, 4,    easeOutQuint, fade"
          "layersOut,           1, 1.5,  linear,       fade"
          "fadeLayersIn,        1, 1.79, almostLinear"
          "fadeLayersOut,       1, 1.39, almostLinear"
          "workspaces,          1, 3.33, easeOutQuint, slide"
          "workspacesIn,        1, 3.33, easeOutQuint, slide"
          "workspacesOut,       1, 3.33, easeOutQuint, slide"
          "zoomFactor,          1, 7,    quick"
          "specialWorkspaceIn,  1, 1.94, easeOutQuint, slide bottom"
          "specialWorkspaceOut, 1, 1.94, easeInQuint,  slide top"
        ];
      };

      dwindle = {
        preserve_split = true;
        smart_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
        focus_on_activate = true;
      };

      input = {
        kb_layout = "br,jp";
        kb_variant = "dvorak";
        kb_options = "ctrl:swapcaps,compose:rctrl";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_rate = 40;
        repeat_delay = 300;
        touchpad = {
          natural_scroll = false;
        };
      };

      workspace = [
        "1,  monitor:DP-1,     defaultName:一"
        "2,  monitor:DP-1,     defaultName:二"
        "3,  monitor:DP-1,     defaultName:三"
        "4,  monitor:DP-1,     defaultName:四"
        "5,  monitor:DP-1,     defaultName:五"
        "6,  monitor:DP-1,     defaultName:六"
        "7,  monitor:DP-1,     defaultName:七"
        "8,  monitor:DP-1,     defaultName:八"
        "9,  monitor:DP-1,     defaultName:九"
        "10, monitor:HDMI-A-1, defaultName:十"
      ];

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod SHIFT, E, exec, /home/joao/.config/hypr/shutdialog"
        "$mainMod SHIFT, space, togglefloating"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, M, togglespecialworkspace, music"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up,   workspace, e-1"
        "$mainMod SHIFT, C, exec, hyprctl reload"
        "CTRL,  Print, exec, grimshot copy area"
        "SHIFT, Print, exec, grimshot copy window"
        ",      Print, exec, grimshot copy anything"
        "SUPER, F,   togglefloating, activewindow"
        "SUPER, F12, exec, hyprctl switchxkblayout"
        "SUPER, N,   exec, swaync-client -t"
      ];

      bindel = [
        ", XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp,   exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext,  exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay,  exec, playerctl play-pause"
        ", XF86AudioPrev,  exec, playerctl previous"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      env = [
        "AQ_DRM_DEVICES,/dev/dri/card1"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "DP-1";
          path = "~/Pictures/Wallpapers/dark";
          fit_mode = "cover";
          timeout = "1800";
        }
        {
          monitor = "HDMI-A-1";
          path = "~/Pictures/Wallpapers/dark";
          fit_mode = "cover";
          timeout = "1800";
        }
      ];
    };
  };

  home.file.".config/hypr/hyprtoolkit.conf".text =
    with config.lib.stylix.colors;
    with config.stylix.fonts;
    ''
      background_color = 0xff${base00}
      base = 0xff${base01}
      text = 0xff${base05}
      alternate_base = 0xff${base02}
      bright_text = 0xff${base06}
      accent = 0xff${base0F}
      accent_secondary = 0xff${base0C}
      font_family = ${sansSerif.name}
      font_family_monospace = ${monospace.name}
    '';
}
