{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    codex.url = "path:/Users/pfsiedler/herp/codex";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, codex }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages = {make = pkgs.gnumake;};
      }
  );
}
