{
  pkgs,
  username,
  ...
}:
{
  # Enable common container config files in /etc/containers.
  virtualisation.containers.enable = true;
  # https://nixos.wiki/wiki/Podman
  # https://nixos.wiki/wiki/Docker
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    devbox
    dive
    skopeo
    docker-compose
    podman-compose
  ];

  home-manager.users.${username} = {
    # https://mynixos.com/home-manager/option/programs.distrobox
    programs.distrobox = {
      enable = true;
      settings = {
        container_image_default = "registry.fedoraproject.org/fedora-toolbox:42";
        container_name_default = "toolbox";
        container_additional_volumes = [
          "/nix/store:/nix/store:ro"
          "/run/current-system:/run/current-system:ro"
          "/etc/static/profiles/per-user:/etc/static/profiles/per-user:ro"
          "/etc/profiles/per-user:/etc/profiles/per-user:ro"
        ];
        container_pre_init_hook = ''
          export PATH=$PATH:/run/current-system/sw/bin
          export SHELL=$(which fish)
        '';
      };
    };
  };
}
