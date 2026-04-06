{
  config,
  lib,
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
    add_newline = true;
    format = "$directory$git_branch$git_status$character";
    right_format = " ";
    directory = {
      home_symbol = "~";
      truncation_length = 6;
      truncate_to_repo = false;
      style = "blue";
      format = "[$home$path]($style) ";
    };
    git_branch = {
      format = "[$branch](bright-black) ";
    };
    git_status = {
      format = "([$ahead_behind](yellow)) ";
      ahead = "⇡";
      behind = "⇣";
      diverged = "⇕";
      up_to_date = "";
    };
    character = {
      success_symbol = "[❯](purple bold)";
      error_symbol = "[❯](red bold)";
      vimcmd_symbol = "[❮](purple bold)";
    };
  };
};

  home.file.".zprofile".source = dotfilesRoot + "/home/.zprofile";
}
