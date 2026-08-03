# -*- mode: justfile -*-

set shell := ["bash", "-c"]
set dotenv-load

hostname := `hostname`

default:
    @just --list

[group('util')]
_go-sudo:
    @sudo --validate

[group('util')]
_validate-hostname HOSTNAME:
    #!/usr/bin/env bash
    if [[ ! "{{ HOSTNAME }}" =~ ^(laptop|wsl)$ ]]; then
        echo "Error: Invalid hostname '{{ HOSTNAME }}'"
        echo "Valid options are:"
        printf "\tlaptop\n"
        printf "\twsl\n"
        exit 1
    fi

# Rebuild everything
rebuild HOSTNAME=hostname: \
    (_validate-hostname HOSTNAME) \
    (_go-sudo) \
    (_nixos-switch HOSTNAME) \
    (_stow HOSTNAME)

# Run switch for system and home configurations
switch HOSTNAME=hostname: \
    (_validate-hostname HOSTNAME) \
    (_go-sudo) \
    (_nixos-switch HOSTNAME) \

# Run build for system and home configurations
build HOSTNAME=hostname: \
    (_validate-hostname HOSTNAME) \
    (_go-sudo) \
    (_nixos-build HOSTNAME) \

# Update Nix flake inputs
update: _go-sudo
    sudo nix flake update

# Upgrade current system
upgrade: _go-sudo
    sudo nixos-rebuild --flake ".#{{ hostname }}" switch

# Upgrade current system safely, after reboot
upgrade-safely-requires-reboot:
    #!/usr/bin/env bash
    sudo nixos-rebuild --flake ".#{{ hostname }}" boot

# Clean Nix store and remove old generations
autoremove: _go-sudo
    sudo nix-collect-garbage -d

[group('nixos')]
_nixos-switch HOSTNAME:
    sudo nixos-rebuild --flake ".#{{ HOSTNAME }}" switch

[group('nixos')]
_nixos-build HOSTNAME:
    nixos-rebuild --flake ".#{{ HOSTNAME }}" build

[group('nixos')]
_nixos-test HOSTNAME:
    sudo nixos-rebuild --flake ".#{{ HOSTNAME }}" test

[group('nixos')]
_nixos-rollback:
    sudo /run/current-system/bin/switch-to-configuration switch

[group('nixos')]
_nixos-generations:
    nix-env -p /nix/var/nix/profiles/system --list-generations

[group('stow')]
_stow HOSTNAME:
    #!/usr/bin/env bash
    target_file="./hosts/{{ HOSTNAME }}/stow_targets"
    if [[ -f "$target_file" ]]; then
        readarray -t pkgs < "$target_file"
        for pkg in "${pkgs[@]}"; do
            [[ -n "$pkg" ]] && stow -d ./stow -t "$HOME" -R "$pkg"
        done
    else
        echo "Warning: No stow_targets found at $target_file"
    fi
