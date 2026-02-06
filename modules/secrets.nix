{config, inputs, ...}:
{
  flake.modules.nixos.base = 
    {pkgs, ...}:
    {
      imports = [
        inputs.agenix.nixosModules.default
      ];
      age.secrets.github-key = {
        file = ../secrets/github.com.age;
        mode = "0600";
        owner = "root";
      };
    };
}
