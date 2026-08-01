{ pkgs, inputs, ... }:
{
  imports = [
    inputs.flatpaks.nixosModules.nix-flatpak
  ];

  services.flatpak.packages = [
    # Pinned
    "io.podman_desktop.PodmanDesktop"
    "org.localsend.localsend_app"
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

  environment.systemPackages = with pkgs; [
    firefox
    ghostty
    steam
  ];
}
