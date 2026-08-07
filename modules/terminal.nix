{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    # https://mynixos.com/home-manager/option/programs.ghostty
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      settings = {
        theme = "Catppuccin Mocha";

        window-padding-x = 15;
        window-padding-y = 5;

        mouse-hide-while-typing = true;

        confirm-close-surface = false;
        quit-after-last-window-closed = true;

        # background-opacity = 0.9;

        font-size = 12;
        font-family = "JetBrainsMono Nerd Font";
        font-family-bold = "JetBrainsMono Nerd Font Bold";
        font-family-italic = "JetBrainsMono Font Italic";
        font-family-bold-italic = "JetBrainsMono Nerd Font Bold Italic";

        keybind = [
          "ctrl+t=new_tab"
          "ctrl+w=close_tab"
          "ctrl+[=previous_tab"
          "ctrl+]=next_tab"
        ];
      };
    };
    catppuccin.ghostty.enable = true;
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-term
  ];
}
