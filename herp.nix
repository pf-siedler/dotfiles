{ pkgs, ... }:

{
  home.username = "pf-siedler";
  home.homeDirectory = "/Users/pf-siedler";
  home.packages = [ pkgs.colima ];
  codex.enable = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-trusted-users = ${builtins.getEnv "GHE_USERNAME"}
      access-tokens = ${builtins.getEnv "GHE_TOKEN"}
    '';
  };
}
