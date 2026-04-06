# Zsh, Starship, and activations (packages live in ../packages.nix).
{
  config,
  lib,
  pkgs,
  dotfilesRoot,
  ...
}:
{
  home.activation.backupPreexistingZshrc = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    zshrc="${config.home.homeDirectory}/.zshrc"
    skip=
    if [[ -L "$zshrc" ]]; then
      target=$(readlink "$zshrc" || true)
      case "$target" in
        /nix/store/*) skip=1 ;;
      esac
    fi
    if [[ -z "$skip" ]] && { [[ -e "$zshrc" ]] || [[ -L "$zshrc" ]]; }; then
      mv -f "$zshrc" "${config.home.homeDirectory}/.zshrc.hm-backup"
    fi
  '';

  home.file."dev_scripts".source = dotfilesRoot + "/home/dev_scripts";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = builtins.readFile (dotfilesRoot + "/home/.zshrc");
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = ''$directory $git_branch$git_status$cmd_duration$character'';
      right_format = "";
      directory = {
        home_symbol = "~";
        truncation_length = 6;
        truncate_to_repo = false;
        style = "blue";
      };
      git_branch = {
        format = ''[$branch](purple)'';
      };
      git_status = {
        format = ''([$all_status$ahead_behind](red) )'';
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        up_to_date = "";
        untracked = "?";
        modified = "*";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };
      cmd_duration = {
        min_time = 2000;
        format = ''[$duration](yellow) '';
        show_milliseconds = false;
      };
      character = {
        success_symbol = "[❯](white)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](white)";
      };
    };
  };

  home.file.".zprofile".source = dotfilesRoot + "/home/.zprofile";
}
