{
  flake.modules.nixos.base = 
    {pkgs, ...}:
    {
      environment.systemPackages = with pkgs; [
        nix-index
        nix-ld
      ];
   
      environment.shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake .#nixos-wsl";
      };
    };
}
