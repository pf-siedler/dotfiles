{ pkgs, inputs, ... }:
let
  # claude-code のみ unstable の nixpkgs を参照する
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config = { allowUnfree = true; };
  };
  # DataDog/pup は nixpkgs 未登録かつ新しい rustc を要求するため unstable でビルドする
  pup = unstablePkgs.callPackage ./pkgs/pup.nix { };
in
{
  home.username = "pf-siedler";
  home.homeDirectory = "/Users/pf-siedler";
  home.packages = [
    unstablePkgs.claude-code
    unstablePkgs.herdr
    pup
  ];
  codex.standardPackages.enable = true;
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-trusted-users = ${builtins.getEnv "GHE_USERNAME"}
      extra-access-tokens = github.com=${builtins.getEnv "GHE_TOKEN"}
    '';
  };
}
