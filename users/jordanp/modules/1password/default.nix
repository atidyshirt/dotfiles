{ dotfilesRoot, ... }:
{
  xdg.configFile."1password/ssh/agent.toml".source =
    "${dotfilesRoot}/config/1password/ssh/agent.toml";
}
