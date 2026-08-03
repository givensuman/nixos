{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.flatpaks.nixosModules.nix-flatpak
    inputs.stylix.nixosModules.stylix
    inputs.catppuccin.nixosModules.catppuccin
  ];

  services.flatpak.enable = true;
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
    {
      name = "gnome-nightly";
      location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";
    }
    {
      name = "cosmic";
      location = "https://apt.pop-os.org/cosmic/cosmic.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    # Runtimes
    "org.freedesktop.Platform/x86_64/25.08"
    # Flatpak utilities
    "com.github.tchx84.Flatseal"
    "io.github.flattool.Warehouse"
    "io.github.flattool.Ignition"
    # GTK/GNOME desktop applications
    "org.gnome.baobab" # Disk Usage Analyzer
    "org.gnome.Boxes"
    "org.gnome.Calendar"
    "org.gnome.Characters"
    "org.gnome.clocks"
    "org.gnome.Contacts"
    "org.gnome.Firmware"
    "org.gnome.font-viewer"
    "org.gnome.Logs"
    "org.gnome.Loupe" # Image Viewer
    "org.gnome.Maps"
    "org.gnome.Papers" # Document Viewer
    "org.gnome.Showtime" # Video Player
    "org.gnome.Snapshot" # Camera
    "org.gnome.TextEditor"
    "org.gnome.Weather"
    "org.gtk.Gtk3theme.adw-gtk3"
    "org.gtk.Gtk3theme.adw-gtk3-dark"
  ];

  services.flatpak.overrides = {
    global = {
      Context.filesystems = [
        "xdg-config/gtk-3.0:ro"
        "xdg-config/gtk-4.0:ro"
      ];
      Context.sockets = [
        "wayland"
        "!x11"
        "!fallback-x11"
      ];
      Environments = {
        GDK_SCALE = "1";
        QT_SCALE_FACTOR = "1";
        GDK_BACKEND = "wayland";
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };
    };
  };

  # https://wiki.nixos.org/wiki/COSMIC
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit # Prefer GTK
    cosmic-player # ""
    cosmic-reader # ""
    cosmic-term # Prefer Ghostty
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
    autoEnable = true;
    flavor = "mocha";
    accent = "lavender";

    # cursors.enable = true;
    # gtk.icon.enable = true;
    grub.enable = true;
    tty.enable = true;
  };
}
