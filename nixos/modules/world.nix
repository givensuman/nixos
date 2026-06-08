{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      function world --description "Manage system from anywhere via Just actions"
          set -l world_dir $HOME/world
          set -l justfile "$world_dir/Justfile"

          if not test -d "$world_dir"
              echo "world: directory not found: $world_dir" >&2
              return 1
          end

          if not test -f "$justfile"
              echo "world: Justfile not found: $justfile" >&2
              return 1
          end

          if test (count $argv) -eq 0
              command just --working-directory "$world_dir" --justfile "$justfile" --list
              return $status
          end

          command just --working-directory "$world_dir" --justfile "$justfile" $argv
      end
    '';
  };

  environment.etc."fish/completions/world.fish".text = ''
    complete -c world -f
    complete -c world -a "(command just \
      --working-directory $HOME/world \
      --justfile $HOME/world/Justfile \
      --summary 2>/dev/null \
    )"
  '';
}
