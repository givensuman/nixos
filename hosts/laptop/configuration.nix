{
  inputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd

    ../../modules/applications.nix
    ../../modules/bareMetal.nix
    ../../modules/commandLine.nix
    ../../modules/containers.nix
    ../../modules/desktop.nix
    ../../modules/git.nix
    ../../modules/programming.nix
    ../../modules/terminal.nix

    ../configuration.nix
    ./hardware-configuration.nix
  ];

  # https://github.com/NixOS/nixos-hardware
  services.fwupd.enable = true;
  hardware.framework.enableKmod = true;
  hardware.framework.amd-7040.preventWakeOnAC = true;
}
