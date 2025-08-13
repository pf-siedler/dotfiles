{ pkgs, ... }:

{
  home.username = "pf-siedler";
  home.homeDirectory = "/Users/pf-siedler";
  home.packages = [ pkgs.colima ];
  codex.enable = true;
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-trusted-users = ${builtins.getEnv "GHE_USERNAME"}
      extra-access-tokens = github.com=${builtins.getEnv "GHE_TOKEN"}
    '';
  };
}
