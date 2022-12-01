{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    codex.url = "path:/Users/pfsiedler/herp/codex";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, codex, ... }:
  let
    eachSystem = flake-utils.lib.eachSystem [
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  in
  {
      inherit flake-utils;
      inherit nixpkgs;
      inherit eachSystem;
    } // (eachSystem (system:
    let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages = {make = pkgs.gnumake;};
  }));
}
