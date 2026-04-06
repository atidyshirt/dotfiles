{ dotfilesRoot, ... }:
{
  programs.git = {
    enable = true;
    signing.format = "openpgp";
    includes = [
      { path = "${dotfilesRoot}/home/.gitconfig.aliases"; }
    ];
  };

  programs.gh = {
    enable = true;
  };
}
