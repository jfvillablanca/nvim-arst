{pkgs, ...}: let
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    extraPython3Packages = _: [];
    withPython3 = true;
    withRuby = true;
    viAlias = false;
    vimAlias = true;
    withNodeJs = true;
    plugins = [];
    customRC = ''
    '';
  };
in {
  nvim-arst = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;
}
