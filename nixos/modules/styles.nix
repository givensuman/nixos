# Everything related to styling and theming goes here.
{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.catppuccin.nixosModules.catppuccin
  ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      serif = config.stylix.fonts.sansSerif;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      fira-sans
      open-sans
      ubuntu-sans
      roboto
    ];
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";

    # cursors.enable = true;
    # gtk.icon.enable = true;
    grub.enable = true;
    tty.enable = true;
  };
}
