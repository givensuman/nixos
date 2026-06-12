{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      gg = "lazygit";
      dd = "lazydocker";
      f = "fd --type f | fzf | sed 's/\ /\\ /g' | xargs $EDITOR";
    };
    binds = {
      "ctrl-f".command = "accept-autosuggestion";
      "ctrl-g".command = "nextd-or-forward-word";
      "ctrl-b".command = "backward-kill-word";
    };
    shellInit = ''
      set --global eza_run_on_cd true
      set --global zoxide_cmd_override cd
      set --global bat_ignore_man true

      set --global EDITOR nvim
      function edit
          $EDITOR $argv
      end

      # hydro prompt
      set --global fish_prompt_pwd_dir_length 999
      set --global hydro_multiline true

      set --local symbol " "
      if set -q DISTROBOX_ENTER_PATH
          set --global hydro_symbol_prompt "$symbol [distrobox] "
      else
          set --global hydro_symbol_prompt "$symbol"
      end

      set --global hydro_symbol_start "\n"
      set --global hydro_symbol_git_dirty "  "
      set --global hydro_symbol_git_ahead " "
      set --global hydro_symbol_git_behind " "

      # catppuccin
      set --global hydro_color_prompt f9e2af
      set --global hydro_color_error f38ba8
      set --global hydro_color_pwd 89b4fa
      set --global hydro_color_git 94e2d5
      set --global hydro_color_duration cba6f7

      # fish
      set --global fish_greeting ""
      set --global fish_key_bindings fish_default_key_bindings
    '';
    plugins = [
      {
        name = "hydro";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "f130b55ee3eaf099eccf588e2a62e5447068d120";
          sha256 = "sha256-Dfq974KpD1mtQKznIlkXfZfDnSF/4MfLTA18Ak0LADE=";
        };
      }
      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "sponge";
        src = pkgs.fetchFromGitHub {
          owner = "meaningful-ooo";
          repo = "sponge";
          rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
          sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
        };
      }
      {
        name = "puffer-fish";
        src = pkgs.fetchFromGitHub {
          owner = "nickeb96";
          repo = "puffer-fish";
          rev = "83174b07de60078be79985ef6123d903329622b8";
          sha256 = "sha256-Dhx5+XRxJvlhdnFyimNxFyFiASrGU4ZwyefsDwtKnSg=";
        };
      }
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "998ad4f5fc9cee36c09840a7e635b56428e554f9";
          sha256 = "sha256-GZ1ZpcaEfbcex6XvxOFJDJqoD9C5out0W4bkkn768r0=";
        };
      }
      {
        name = "reload.fish";
        src = pkgs.fetchFromGitHub {
          owner = "kenji-miyake";
          repo = "reload.fish";
          rev = "181ea65bfabc544e0b3b3dd03615900959ce32ca";
          sha256 = "sha256-dabzsp5IQwvrF9rzpIff+TYAqVYBrmhtLvemdRFX0DI=";
        };
      }
      {
        name = "gitnow";
        src = pkgs.fetchFromGitHub {
          owner = "joseluisq";
          repo = "gitnow";
          rev = "818996a5a1de5af697d909a44fb27ac1c8856aad";
          sha256 = "sha256-3pLOeeY1Wo9GJVhA2YxSTlVR0wWG9hHpr3BcHHfPrnA=";
        };
      }
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "patrickf1";
          repo = "fzf.fish";
          rev = "0069dbbe06cc05482bfb13063b4b4eac26318992";
          sha256 = "sha256-H7HgYT+okuVXo2SinrSs+hxAKCn4Q4su7oMbebKd/7s=";
        };
      }
      {
        name = "safe-rm";
        src = pkgs.fetchFromGitHub {
          owner = "fishingline";
          repo = "safe-rm";
          rev = "a9299d6b0bd9053a42c383ffbdbd1b15cb29f074";
          sha256 = "sha256-chou3NBxs/RZqVJd8oPmlz2LqkZhfpVDKqUspXvU2KY=";
        };
      }
      {
        name = "fish-bat";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-bat";
          rev = "92f5043df1aa80ec9159768f74af5218e3d4699a";
          sha256 = "sha256-xwOOWSzWBNShNTMEJhONw6IGMpnlNT64PjBBuVkWncc=";
        };
      }
      {
        name = "fish-zoxide";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-zoxide";
          rev = "5adf910d22af8d35f85dc16234ce78b48e7676f1";
          sha256 = "sha256-yGi4qs2XFm8SDy3YuvIR6AwQqusKz2r8/QRpv+fWCVs=";
        };
      }
      {
        name = "fish-autovenv";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-autovenv";
          rev = "d09ac1c3b32be39a3ca3210cfda7b63f5707d94b";
          sha256 = "sha256-+cIN0T5QQyseGuf6UBxEFtrkYGrpBu31FN1o90HdyuA=";
        };
      }
      {
        name = "fish-archive";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-archive";
          rev = "d834b8dd28134e234e136e414d2444649fa88208";
          sha256 = "sha256-h35kzfUkBTvALva2MDFxthQGY8HW5BsF/DEp3Kj/OfM=";
        };
      }
      {
        name = "fish-copyutils";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-copyutils";
          rev = "064db38082dc282a4993afbb5f26351fcad4f30e";
          sha256 = "sha256-9ImlYINgUwRGxiLQpWwm7t6HqHZRi39w139C6XN3kZU=";
        };
      }
      {
        name = "fish-eza";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-eza";
          rev = "fb2d8c70e6d894d3b55259e4c4e659a4850581b0";
          sha256 = "sha256-cFUHMSEMxq/XSeKOLCUArgM9ogY6NqrPmhxaHn5bbQs=";
        };
      }
      {
        name = "fish-peek";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-peek";
          rev = "6257a26ef2c49a2713b4e2e2c4f981d782531a15";
          sha256 = "sha256-gQa5YTAylWmQGy40bdmEo4nyN6/exi4yeVsNq41LAjo=";
        };
      }
      {
        name = "fish-ripgrep";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-ripgrep";
          rev = "bdf9d60021ea3bd76a5dd16176514e08818fd101";
          sha256 = "sha256-s2QpX8wqMMK1VbNJAxjIvZi3NQzg5H3uppLPJfUYVnk=";
        };
      }
      {
        name = "fish-fd";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-fd";
          rev = "3d3310e649f8c1fe906835c0fc3373f79df65271";
          sha256 = "sha256-AFOhL2uLP2GQhSgzRa39Iz/Ze3CrZJ6M+RVDOusO054=";
        };
      }
      {
        name = "fish-cdutils";
        src = pkgs.fetchFromGitHub {
          owner = "givensuman";
          repo = "fish-cdutils";
          rev = "445a61ae732410c3a80e7eeefafee7c76b67e586";
          sha256 = "sha256-DIHXvuJSo0vKPMmF6G22DrKbat06AeKEmlFPqHPXN0o=";
        };
      }
    ];
  };

  catppuccin.fish.enable = true;
}
