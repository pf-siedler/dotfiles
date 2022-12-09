{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    codex.url =
      "github:herp-inc/codex/e92a3f38bd777a1e24b2d4308d302ebf5a7b0688";
  };

  outputs = { self, nixpkgs, home-manager, codex ? { }, ... }@inputs: {
    homeConfigurations.herp = let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.x86_64-darwin;
    in home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./home.nix
        codex.hmModule.x86_64-darwin
        ({ ... }: {
          home.username = "pfsiedler";
          home.homeDirectory = "/Users/pfsiedler";
          home.packages = [ pkgs.cachix ];
          codex.enable = true;
        })
      ];
    };
    homeConfigurations.surface = let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./home.nix
        ({ ... }: {
          home.username = "pfsiedler";
          home.homeDirectory = "/home/pfsiedler";
        })
      ];
    };
  };
}
