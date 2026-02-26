{
  inputs,
  lib,
  config,
  self,
  ...
}@flakeArgs:
{
  options.meta = lib.mkOption {
    type = lib.types.anything;
  };
}
