{ pkgs, ... }:
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # wlsunset package available for manual use.
  # Note: services.wlsunset is not a valid NixOS module option in current nixpkgs.
  # To run automatically, configure as a systemd user service.
  environment.systemPackages = [ pkgs.wlsunset ];
}
