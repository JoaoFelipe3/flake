{
  description = "joaozin003 home";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # == DEPENDENCIES ==

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; 
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uiua = {
      url = "github:uiua-lang/uiua";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    freesm = {
      url = "github:FreesmTeam/FreesmLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## == PERSONAL STUFF ==
    color-palette = {
      url = "github:JoaoFelipe3/color-palette";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      uiua,
      zen-browser,
      hyprland,
      hyprland-plugins,
      plasma-manager,
      color-palette,
      ...
    }@inputsPre:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      inputs = inputsPre // {
        color-palette = builtins.fromJSON (builtins.readFile "${color-palette}/colors.json");
      };
    in
    {
      nixosConfigurations."iusenixbtw" = nixpkgs.lib.nixosSystem {
        modules = [
          stylix.nixosModules.stylix
          ./nixos/configuration.nix
        ];

        specialArgs = { inherit inputs; };
      };

      homeConfigurations."joao" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          stylix.homeModules.stylix
          plasma-manager.homeModules.plasma-manager
          ./home/home.nix
        ];

        extraSpecialArgs = { inherit inputs; };
      };
    };
}
