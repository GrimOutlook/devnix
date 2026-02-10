{
  # When ssh-perso key is not available, use a passphrase-protected key for GitHub only
  flake.modules.homeManager.ssh-github =
    { config, ... }:
    {
      services.ssh-agent.enable = true;
      programs.ssh.matchBlocks."gitlab.avmc.army.mil".identityFile = config.age.secrets.gitlab-key.path;
      age.secrets.gitlab-key = {
        file = ../../../secrets/ssh/gitlab.avmc.army.mil.age;
        mode = "0600";
        owner = "root";
      };
    };
}
