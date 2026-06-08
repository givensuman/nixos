# Hardware configuration for Frameowkr 13 laptop.
{ inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd
  ];

  # https://github.com/NixOS/nixos-hardware
  services.fwupd.enable = true;
  hardware.framework.enableKmod = true;
  hardware.framework.amd-7040.preventWakeOnAC = true;
}
