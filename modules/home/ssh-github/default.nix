{
  # When ssh-perso key is not available, use a passphrase-protected key for GitHub only
  flake.modules.homeManager.ssh-github =
    { config, ... }:
    {
      # services.ssh-agent.enable = true;
      # programs.ssh.matchBlocks."github.com".identityFile = config.age.secrets.github-key.path;
      # age.secrets.github-key = {
      #   file = ../../../secrets/ssh/github.com.age;
      #   mode = "0600";
      # };
    };
}
