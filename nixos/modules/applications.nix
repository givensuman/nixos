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
    "org.nickvision.tubeconverter" # Media downloader
    "io.github.kriptolix.Poliedros" # Dice roller
    "com.obsproject.Studio"
    "org.kde.kdenlive"
  ];

  environment.systemPackages = with pkgs; [
    bazaar
    firefox
    ghostty
    steam
  ];
}
