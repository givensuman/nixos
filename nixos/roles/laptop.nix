{
  imports = [
    ../modules/applications.nix
    ../modules/containers.nix
    ../modules/desktop.nix
    ../modules/display.nix
    ../modules/framework.nix
    ../modules/programming.nix
    ../modules/styles.nix
    ../modules/system.nix
    ../modules/world.nix
  ];

  # Laptop-specific settings
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;
}
