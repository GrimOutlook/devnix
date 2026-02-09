{ inputs, lib, config, ... }:
{
  flake.modules.nixos.base.programs.nixvim = 
    {pkgs, ...}:
    {
      plugins.snacks.settings.picker.enable = true;
      keymaps = [
        {
          mode = "n";
          key = "<leader>b";
          action = "<cmd>lua Snacks.picker.buffers()<cr>";
          options = {
            desc = "Find buffers";
          };
        }
        {
          mode = "n";
          key = "<leader>R";
          action = "<cmd>lua Snacks.picker.resume()<cr>";
          options = {
            desc = "Reopen Last Picker";
          };
        }
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>lua Snacks.picker.files()<cr>";
          options = {
            desc = "Files";
          };
        }
        {
          mode = "n";
          key = "<leader>fr";
          action = "<cmd>lua Snacks.picker.recent({ filter= { cwd = true }, current = false })<cr>";
          options = {
            desc = "Recent Files (CWD)";
          };
        }
      ];
    };
}
