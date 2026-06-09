{
  programs.mise = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    globalConfig = {
      tools = {
        bun = "latest";
        deno = "latest";
        go = "latest";
        "go:golang.org/x/tools/gopls" = "latest";
        golangci-lint = "latest";
        golangci-lint-langserver = "latest";
        node = "latest";
        pipx = "latest";
        rust = "latest";
        shellcheck = "latest";
        shfmt = "latest";
      };
      settings = {
        always_keep_download = false;
        always_keep_install = false;
        plugin_autoupdate_last_check_duration = "1 week";
        not_found_auto_install = true;
        env_file = ".env";
        python.uv_venv_auto = true;
      };
    };
  };

  home.sessionVariables = {
    GOPATH = "$HOME/.go";
  };
}
