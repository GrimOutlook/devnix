{ inputs, lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zoxide # Fast cd command that learns your habits
  ];

  programs.zoxide.enable = true;

  environment.variables = {
    _ZO_ECHO = 1;
  };
}
