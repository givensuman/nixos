{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    # https://mynixos.com/home-manager/options/programs.git
    programs.git = {
      enable = true;
      settings = {
        credential."https://github.com" = {
          helper = [
            "${pkgs.gh}/bin/gh auth git-credential"
          ];
        };
        credential."https://gist.github.com" = {
          helper = [
            "${pkgs.gh}/bin/gh auth git-credential"
          ];
        };
        user = {
          name = "givensuman";
          email = "givensuman@duck.com";
        };
        filter."lfs" = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };
        core.whitespace = "trailing-space,space-before-tab";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        alias = {
          uncommit = "reset HEAD^";
          amend = "commit --amend -C HEAD";

          # One line log with colors and decorations
          l = "log --pretty=format:\"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=short";

          # Shorthand
          a = "add";
          ap = "add -p";
          c = "commit --v";
          ca = "commit -a --v";
          cm = "commit -m";
          cam = "commit -a -m";
          m = "commit --amend --v";
          d = "d";
          ds = "diff --s";
          dc = "diff --c";
          s = "status -s";
          co = "c";
          cob = "checkout -b";

          # List branches sorted by last modified
          b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";

          # List aliases
          la = "!git config -l | grep alias | cut -c 7-";
        };
      };
    };

    # https://mynixos.com/home-manager/options/programs.lazygit
    programs.lazygit = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings = {
        keybinding.universal = {
          universal = {
            scrollUpMain = "<c-b>";
            scrollDownMain = "<c-f>";
          };
        };
      };
    };
    catppuccin.lazygit.enable = true;

    home.packages = [
      pkgs.github-cli # in /stow
    ];
  };
}
