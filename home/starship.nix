{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  home.file.".config/starship.toml".text = with config.lib.stylix.colors; ''
    "$schema" = 'https://starship.rs/config-schema.json'

    format = """
    [](base15)\
    $os\
    $username\
    [](prev_bg bg:base03)\
    $directory\
    $git_branch\
    $git_status\
    $docker_context\
    [](prev_bg bg:base02)\
    $c\
    $rust\
    $golang\
    $nodejs\
    $php\
    $java\
    $kotlin\
    $haskell\
    $python\
    $conda\
    [](prev_bg bg:base01)\
    $time\
    [ ](prev_bg)\
    $cmd_duration\
    $line_break\
    $status\
    $character"""

    palette = 'base16'

    [palettes.base16]
    base00 = "#${base00}"
    base01 = "#${base01}"
    base02 = "#${base02}"
    base03 = "#${base03}"
    base04 = "#${base04}"
    base05 = "#${base05}"
    base06 = "#${base06}"
    base07 = "#${base07}"
    base08 = "#${base08}"
    base09 = "#${base09}"
    base10 = "#${base0A}"
    base11 = "#${base0B}"
    base12 = "#${base0C}"
    base13 = "#${base0D}"
    base14 = "#${base0E}"
    base15 = "#${base0F}"
    base16 = "#${base10}"
    base17 = "#${base11}"
    base18 = "#${base12}"
    base19 = "#${base13}"
    base20 = "#${base14}"
    base21 = "#${base15}"
    base22 = "#${base16}"
    base23 = "#${base17}"

    [os]
    disabled = false
    style = "bg:prev_fg fg:base00 bold"

    [os.symbols]
    Windows = ""
    Ubuntu = "󰕈"
    SUSE = ""
    Raspbian = "󰐿"
    Mint = "󰣭"
    Macos = "󰀵"
    Manjaro = ""
    Linux = "󰌽"
    Gentoo = "󰣨"
    Fedora = "󰣛"
    Alpine = ""
    Amazon = ""
    Android = ""
    Arch = "󰣇"
    Artix = "󰣇"
    CentOS = ""
    Debian = "󰣚"
    NixOS = ""
    Redhat = "󱄛"
    RedHatEnterprise = "󱄛"

    [username]
    show_always = true
    style_user = "bg:prev_bg fg:base00 bold"
    style_root = "bg:prev_bg fg:base00 bold"
    format = '[ $user ]($style)'

    [directory]
    style = "bg:prev_bg fg:base05"
    format = "[ $path ]($style)"
    truncation_length = 2
    truncation_symbol = "…/"
    before_repo_root_style = "fg:base03"

    [directory.substitutions]
    "Documents" = "󰈙"
    "Downloads" = ""
    "Music" = "󰝚"
    "Pictures" = ""
    "Developer" = ""

    [git_branch]
    symbol = "[](bg:prev_bg base12)"
    style = "bg:prev_bg"
    format = '[$symbol $branch ]($style)'

    [git_status]
    style = "bg:prev_bg"
    format = '[($all_status $ahead_behind)]($style)'

    conflicted = "[CONFLICT! ](bold bg:prev_bg fg:base08)"
    stashed = "[](bg:prev_bg fg:base09)"
    deleted = "󰆴"
    modified = "󰏫"
    staged = "[](bg:prev_bg fg:base11)"
    untracked = "[?](bg:prev_bg fg:base04)"

    ahead = "[$count](bg:prev_bg fg:base0B)"
    behind = "[$count](bg:prev_bg fg:base08)"

    [nodejs]
    symbol = ""
    style = "bg:surface1"
    format = '[[ $symbol($version) ](bg:prev_bg fg:base11)]($style)'

    [c]
    symbol = " "
    style = "bg:surface1"
    format = '[[ $symbol($version) ](fg:base13 bg:prev_bg)]($style)'

    [rust]
    symbol = ""
    style = "bg:prev_bg"
    format = '[[ $symbol($version) ](fg:base09 bg:prev_bg)]($style)'

    [golang]
    symbol = ""
    style = "bg:prev_bg"
    format = '[[ $symbol($version) ](fg:base12 bg:prev_bg)]($style)'

    [php]
    symbol = ""
    style = "bg:prev_bg"
    format = '[[ $symbol($version) ](fg:base13 bg:prev_bg)]($style)'

    [java]
    symbol = " "
    style = "bg:prev_bg"
    format = '[[ $symbol($version) ](fg:base08 bg:prev_bg)]($style)'

    [kotlin]
    symbol = ""
    style = "bg:prev_bg"
    format = '[[ $symbol($version) ](fg:base13 bg:prev_bg)]($style)'

    [haskell]
    symbol = ""
    style = "bg:prev_bg"
    format = '[[ $symbol($version) ](fg:base14 bg:prev_bg)]($style)'

    [python]
    symbol = ""
    style = "bg:prev_bg"
    format = '[[ $symbol($version)(\(#$virtualenv\)) ](fg:base13 bg:prev_bg)]($style)'

    [docker_context]
    symbol = ""
    style = "bg:prev_bg"
    format = '[[ $symbol( $context) ](fg:base13 bg:prev_bg)]($style)'

    [conda]
    symbol = "  "
    style = "fg:base11 bg:prev_bg"
    format = '[$symbol$environment ]($style)'
    ignore_base = false

    [time]
    disabled = false
    time_format = "%I:%M %p"
    style = "bg:base14"
    format = '[[  $time ](fg:base05 bg:prev_bg)]($style)'

    [line_break]
    disabled = false

    [status]
    format = "[$status]($style)"
    style = "fg:base08"
    disabled = false

    [character]
    disabled = false
    success_symbol = '[❯](bold fg:base11)'
    error_symbol = '[❯](bold fg:base08)'
    vimcmd_symbol = '[❮](bold fg:base11)'
    vimcmd_replace_one_symbol = '[❮](bold fg:base13)'
    vimcmd_replace_symbol = '[❮](bold fg:base13)'
    vimcmd_visual_symbol = '[❮](bold fg:base10)'

    [cmd_duration]
    format = " took $duration "
    style = "bg:base13"
    disabled = false
    min_time = 10000
  '';
}
