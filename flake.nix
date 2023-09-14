{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    codex.url = "git+ssh://git@github.com/herp-inc/codex";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, codex, ... }@inputs:
    {
      homeConfigurations.herp =
        let
          system = "aarch64-darwin";
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
            codex.hmModule.aarch64-darwin
            ({ ... }: {
              home.username = "pf-siedler";
              home.homeDirectory = "/Users/pf-siedler";
              codex.enable = true;
            })
          ];
        };
      homeConfigurations.surface =
        let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
            ({ pkgs, ... }: {
              home.username = "pfsiedler";
              home.homeDirectory = "/home/pfsiedler";
              home.packages = [
                pkgs.nixpkgs-fmt
                pkgs.jq
                pkgs.gnumake
              ];
            })
          ];
        };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.gnumake pkgs.nixfmt pkgs.shellcheck ];
        };
      });
}
