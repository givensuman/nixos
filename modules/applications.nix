{
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [
    inputs.flatpaks.nixosModules.nix-flatpak
    inputs.catppuccin.nixosModules.catppuccin
  ];

  services.flatpak.packages = [
    # Pinned
    "io.podman_desktop.PodmanDesktop"
    "com.spotify.Client"
    "io.github.milkshiift.GoofCord"
    # Additional
    "de.haeckerfelix.Fragments"
    "org.nickvision.tubeconverter"
    "com.obsproject.Studio"
    "org.kde.kdenlive"
    "org.blender.Blender"
    "org.inkscape.Inkscape"
    "org.gimp.GIMP"
  ];

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    ghostty
    steam
  ];

  home-manager.users.${username} = {
    programs.firefox = {
      enable = true;
      # preferences = {
      #   "widget.gtk.libadwaita-colors.enabled" = false;
      # };
    };

    catppuccin.firefox.enable = true;
  };
}
