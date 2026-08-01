{
  description = "given's NixOS flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Remote flakes
    hardware.url = "github:NixOS/nixos-hardware/master";
    flatpaks.url = "github:gmodena/nix-flatpak";
    stylix.url = "github:nix-community/stylix";
    catppuccin.url = "github:catppuccin/nix";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#hostname'
      nixosConfigurations = {
        gandalf = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/hosts/gandalf/configuration.nix ];
        };
        work-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/hosts/work-desktop/configuration.nix ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#username@hostname'
      homeConfigurations = {
        "given@gandalf" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/hosts/gandalf.nix ];
        };
        "given@work-desktop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/hosts/work-desktop.nix ];
        };
      };
    };
}
