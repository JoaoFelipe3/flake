{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "joao";
  home.homeDirectory = "/home/joao";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  imports = [
    inputs.zen-browser.homeModules.beta
    ../stylix/stylix.nix
    ./hypr.nix # remove later
    ./kde.nix
    ./starship.nix
    ./openrgb.nix
  ];

  # ALLOW UNFREE
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Packages I need:
    pkgs.waybar
    pkgs.wezterm
    pkgs.ghostty
    # pkgs.rofi
    pkgs.starship
    pkgs.swaynotificationcenter # WHY SO LONG
    pkgs.vesktop
    pkgs.swaybg

    # hypr:
    pkgs.hyprpolkitagent
    pkgs.hyprcursor
    pkgs.hyprshutdown
    pkgs.hyprlauncher

    # gaming :3
    pkgs.srb2
    pkgs.tetrio-desktop # waiting for PLUSv28

    # extras:
    pkgs.fastfetch
    # pkgs.neowall
    pkgs.neovim
    pkgs.rmpc
    pkgs.thunar
    pkgs.catppuccin-cursors.mochaTeal
    pkgs.nwg-look
    pkgs.grim
    pkgs.slurp
    pkgs.sway-contrib.grimshot
    pkgs.feh
    pkgs.vivid
    inputs.uiua.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.pwvucontrol
    pkgs.btop
    pkgs.clang
    pkgs.obs-studio

    # make code prettier
    pkgs.nixfmt

    # funsies:
    pkgs.sl
    pkgs.gti
    pkgs.cowsay
    pkgs.fortune
    pkgs.lolcat
    pkgs.cmatrix
    inputs.freesm.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = wezterm.config_builder()

      config.enable_tab_bar = false
      config.enable_wayland = false -- sneaky workaround to get wezterm to work on hyprland
      config.font = wezterm.font_with_fallback {'FantasqueSansM Nerd Font Mono', 'Uiua386'}
      config.font_size = 9
      config.window_background_opacity = 0.75

      return config
    '';
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 9;
      background-opacity = 0.75;
      bell-features = "system";
    };
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config.show_banner = false
      $env.config.buffer_editor = "nvim"

      def --env clean [] {
          cd; clear
      }

      # cargo and lean and .local/bin/
      $env.path ++= ["~/.cargo/bin", "~/.elan/bin", "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/", "~/.local/bin"]

      # LS_COLORS
      $env.ls_colors = (vivid generate ansi)

      mkdir ($nu.data-dir | path join "vendor/autoload")
      # starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

      $env.config.hooks = {
          display_output: {table -e}
      }
    '';
    shellAliases = {
      vim = "nvim";
      la = "ls -a";
      bell = ''print "\a"'';
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire output"
      }
    '';
    network.listenAddress = "/tmp/mpd_socket";
  };

  services.swaync = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    style = ''
      * {
          font-family: "FantasqueSansM Nerd Font";
          font-size: 12px;
      }

      window#waybar {
          background: linear-gradient(rgba(32,35,33,0.6) 0%, transparent 100%);
          color: @base05;
      }

      window#waybar.bottom {
          background: linear-gradient(transparent 0%, rgba(32,35,33,0.6) 100%);
      }

      .module {
          margin: 0 0.5em;
          padding: 0 0.5em;
          /* background: #11111b; */
          background: transparent;
          /* border-radius: 5px; */
          /* border: 1px solid #313244; */
      }

      window#waybar.top .module {
          border-radius: 0 0 5px 5px;
      }

      window#waybar.bottom .module {
          border-radius: 5px 5px 0 0;
      }

      tooltip {
          background-color: @base03;
          border-color: @base04;
      }

      tooltip label {
          color: @base05;
      }

      #mode {
          background: @base0C;
          color: @base00;
      }

      #workspaces button {
          background-color: transparent;
          color: @base05;
          border-radius: 0 0 5px 5px;
          padding: 0 0.5em;
          border: none;
      }

      #workspaces button.active {
          background-color: @base0F;
          color: @base00;
      }

      #workspaces button:hover {
          background: @base01;
          box-shadow: none;
          text-shadow: none;
          border: none;
      }

      #workspaces button.active:hover {
          background-color: @base0F;
          color: @base00;
      }

      #network {
          background: @base0B;
          color: @base00;
      }

      #network.disconnected {
          background: @base08;
      }

      #mpd {
          transition: background 0.5s linear;
      }

      #workspaces button.special.active,
      #mpd.playing {
          background: linear-gradient(to right, @base08, @base0A 16.7%, @base0B 33.3%, @base0C 50%, @base0D 66.7%, @base0E 83.3%, @base08 100%) 0 0 / 200% 100%;
          color: @base00;
          animation: rainbow 2s linear infinite;
      }

      @keyframes rainbow {
          100% {
              background-position: 200% 0%;
          }
      }

      #custom-tl.a,
      #custom-tl.a\+ {
          color: @base0B;
      }

      #custom-tl.b,
      #custom-tl.b- {
          color: @base0D;
      }

      #custom-tl.b\+ {
          color: @base0C;
      }

      #custom-tl.c,
      #custom-tl.c\+,
      #custom-tl.c-,
      #custom-tl.d,
      #custom-tl.d\+ {
          color: @base0E;
      }

      #custom-tl.s,
      #custom-tl.s\+,
      #custom-tl.s-,
      #custom-tl.ss {
          color: @base0A;
      }

      #custom-tl.u {
          color: @base08;
      }

      #custom-tl.x {
          color: @base0E;
      }

      #custom-tl.z {
          color: @base04;
      }

      #custom-power {
          color: @base08;
      }
    '';
  };

  programs.zen-browser = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "element" = {
          "children" = map mkLiteral [
            "element-icon"
            "element-text"
          ];
        };
      };
  };

  stylix.targets = {
    gtk.enable = true;

    wezterm.enable = true;
    ghostty.enable = true;
    nushell.enable = true;
    waybar = {
      enable = true;
      addCss = false;
    };

    swaync.enable = true;
    zen-browser = {
      enable = true;
      profileNames = [ "default" ];
    };
    rofi.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/vesktop/themes/system24.theme.css".text = with config.lib.stylix.colors.withHashtag; ''
      /**
       * @name midnight
       * @description a dark, customizable discord theme.
       * @author refact0r
       * @version 2.1.1
       * @invite nz87hXyvcy
       * @website https://github.com/refact0r/midnight-discord
       * @source https://github.com/refact0r/midnight-discord/blob/master/themes/midnight.theme.css
       * @authorId 508863359777505290
       * @authorLink https://www.refact0r.dev
      */

      /* import theme modules */
      @import url('https://refact0r.github.io/midnight-discord/build/midnight.css');

      body {
          /* font options */
          --font: "${config.stylix.fonts.sansSerif.name}"; /* change to "" for default discord font */
          --code-font: "${config.stylix.fonts.monospace.name}"; /* change to "" for default discord font */
          font-weight: 400; /* normal text font weight. DOES NOT AFFECT BOLD TEXT */

          /* sizes */
          --gap: 8px; /* spacing between panels */
          --divider-thickness: 2px; /* thickness of unread messages divider and highlighted message borders */
          --border-thickness: 2px; /* thickness of borders around main panels. DOES NOT AFFECT OTHER BORDERS */

          /* animation/transition options */
          --animations: on; /* off: disable animations/transitions, on: enable animations/transitions */
          --list-item-transition: 0.2s ease; /* transition for list items */
          --dms-icon-svg-transition: 0.4s ease; /* transition for the dms icon */
          --border-hover-transition: 0.2s ease; /* transition for borders when hovered */

          /* top bar options */
          --top-bar-height: var(--gap); /* height of the top bar (discord default is 36px, old discord style is 24px, var(--gap) recommended if button position is set to titlebar) */
          --top-bar-button-position: titlebar; /* off: default position, hide: hide buttons completely, serverlist: move inbox button to server list, titlebar: move inbox button to channel titlebar (will hide title) */
          --top-bar-title-position: off; /* off: default centered position, hide: hide title completely, left: left align title (like old discord) */
          --subtle-top-bar-title: off; /* off: default, on: hide the icon and use subtle text color (like old discord) */

          /* window controls */
          --custom-window-controls: on; /* off: default window controls, on: custom window controls */
          --window-control-size: 14px; /* size of custom window controls */

          /* dms button options */
          --custom-dms-icon: custom; /* off: use default discord icon, hide: remove icon entirely, custom: use custom icon */
          --dms-icon-svg-url: url('https://refact0r.github.io/midnight-discord/assets/Font_Awesome_5_solid_moon.svg'); /* icon svg url. MUST BE A SVG. */
          --dms-icon-svg-size: 90%; /* size of the svg (css mask-size property) */
          --dms-icon-color-before: var(--icon-subtle); /* normal icon color */
          --dms-icon-color-after: var(--white); /* icon color when button is hovered/selected */
          --custom-dms-background: off; /* off to disable, image to use a background image (must set url variable below), color to use a custom color/gradient */
          --dms-background-image-url: url(""); /* url of the background image */
          --dms-background-image-size: cover; /* size of the background image (css background-size property) */
          --dms-background-color: linear-gradient(70deg, var(--blue-2), var(--purple-2), var(--red-2)); /* fixed color/gradient (css background property) */

          /* background image options */
          --background-image: off; /* off: no background image, on: enable background image (must set url variable below) */
          --background-image-url: url(""); /* url of the background image */

          /* transparency/blur options */
          /* NOTE: TO USE TRANSPARENCY/BLUR, YOU MUST HAVE TRANSPARENT BG COLORS. FOR EXAMPLE: --bg-4: hsla(220, 15%, 10%, 0.7); */
          --transparency-tweaks: off; /* off: no changes, on: remove some elements for better transparency */
          --remove-bg-layer: off; /* off: no changes, on: remove the base --bg-3 layer for use with window transparency (WILL OVERRIDE BACKGROUND IMAGE) */
          --panel-blur: off; /* off: no changes, on: blur the background of panels */
          --blur-amount: 12px; /* amount of blur */
          --bg-floating: var(--bg-3); /* set this to a more opaque color if floating panels look too transparent. only applies if panel blur is on  */

          /* chatbar options */
          --custom-chatbar: off; /* off: default chatbar, separated: chatbar separated from chat */
          --chatbar-height: 47px; /* height of the chatbar (56px by default, 47px to align with user panel, 56px recommended for separated) */

          /* other options */
          --small-user-panel: on; /* off: default user panel, on: smaller user panel like in old discord */
      }

      /* color options */
      :root {
          --colors: on; /* off: discord default colors, on: midnight custom colors */

          /* text colors */
          --text-0: var(--bg-4); /* text on colored elements */
          --text-1: ${base05}; /* other normally white text */
          --text-2: ${base05}; /* headings and important text */
          --text-3: ${base05}; /* normal text */
          --text-4: ${base04}; /* icon buttons and channels */
          --text-5: ${base03}; /* muted channels/chats and timestamps */

          /* background and dark colors */
          --bg-1: ${base03}; /* dark buttons when clicked */
          --bg-2: ${base02}; /* dark buttons */
          --bg-3: ${base01}; /* spacing, secondary elements */
          --bg-4: ${base00}; /* main background color */
          --hover: rgba(from ${base04} r g b / 0.3); /* channels and buttons when hovered */
          --active: rgba(from ${base04} r g b / 0.3); /* channels and buttons when clicked or selected */
          --active-2: rgba(from ${base04} r g b / 0.3); /* extra state for transparent buttons */
          --message-hover: rgba(from ${base02} r g b / 0.1); /* messages when hovered */

          /* accent colors */
          --accent-1: ${base0F}; /* links and other accent text */
          --accent-2: ${base0F}; /* small accent elements */
          --accent-3: ${base0F}; /* accent buttons */
          --accent-4: ${base0F}; /* accent buttons when hovered */
          --accent-5: ${base0F}; /* accent buttons when clicked */
          --accent-new: var(--red-2); /* stuff that's normally red like mute/deafen buttons */
          --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent); /* background of messages that mention you */
          --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent); /* background of messages that mention you when hovered */
          --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent); /* background of messages that reply to you */
          --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent); /* background of messages that reply to you when hovered */

          /* status indicator colors */
          --online: var(--green-2); /* change to #43a25a for default */
          --dnd: var(--red-2); /* change to #d83a42 for default */
          --idle: var(--yellow-2); /* change to #ca9654 for default */
          --streaming: var(--purple-2); /* change to #593695 for default */
          --offline: var(--text-4); /* change to #83838b for default offline color */

          /* border colors */
          --border-light: var(--hover); /* general light border color */
          --border: var(--active); /* general normal border color */
          --border-hover: var(--accent-2); /* border color of panels when hovered */
          --button-border: hsl(235, 0%, 100%, 0.1); /* neutral border color of buttons */

          /* base colors */
          --red-1: ${base12};
          --red-2: ${base08};
          --red-3: ${base08};
          --red-4: ${base08};
          --red-5: ${base08};

          --green-1: ${base14};
          --green-2: ${base0B};
          --green-3: ${base0B};
          --green-4: ${base0B};
          --green-5: ${base0B};

          --blue-1: ${base16};
          --blue-2: ${base0D};
          --blue-3: ${base0D};
          --blue-4: ${base0D};
          --blue-5: ${base0D};

          --yellow-1: ${base13};
          --yellow-2: ${base0A};
          --yellow-3: ${base0A};
          --yellow-4: ${base0A};
          --yellow-5: ${base0A};

          --purple-1: ${base17};
          --purple-2: ${base0E};
          --purple-3: ${base0E};
          --purple-4: ${base0E};
          --purple-5: ${base0E};
      }

      .search_c322aa > .searchBar_c322aa {
          width: 32px !important;
          background: none;
          border-color: transparent;
          transition: background .25s ease,
              width .25s ease,
              border-color .25s ease;
      }

      .search_c322aa > .searchBar_c322aa .DraftEditor-root {
          padding-right: 0px !important;
      }

      .search_c322aa.active > .searchBar_c322aa,
      .search_c322aa:focus-within > .searchBar_c322aa {
          width: 244px !important;
          background: var(--background-gradient-low, var(--input-background-default));
          border-color: var(--input-border-default);
          transition: all .4s ease;
      }

      .search_c322aa.active .DraftEditor-root:hover,
      .search_c322aa:focus-within .DraftEditor-root:hover {
          cursor: text;
      }

      .search_c322aa > .searchBar_c322aa .icon_c322aa {
          margin-right: 5px;
      }

      .search__49676 {
          margin: 0 !important;
          width: 100%;
          min-width: 0;
      }

      .iconLayout__0c4c4, .searchBar_c322aa {
          cursor: pointer;
      }
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/joao/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
