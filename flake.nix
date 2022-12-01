{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    codex.url = "path:/Users/pfsiedler/herp/codex";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  {
    homeConfigurations.herp =
      let
        system = "x86_64-darwin";
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
      in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ({...}:{
            home.username = "pfsiedler";
            home.homeDirectory = "/Users/pfsiedler";
          })
        ];
      };
  };
}
