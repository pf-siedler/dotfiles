{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    codex.url = "git+ssh://git@github.com/herp-inc/codex";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, codex, ... }@inputs:
    {
      homeConfigurations = {
        beelink = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
            ({ pkgs, ... }: {
              home.username = "pfsiedler";
              home.homeDirectory = "/home/pfsiedler";
              programs.vscode.enable = pkgs.lib.mkForce false;
            })
          ];
        };
        herp = let
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
            ./starship-warp.nix
            codex.hmModule.aarch64-darwin
            ({ ... }: {
              home.username = "pf-siedler";
              home.homeDirectory = "/Users/pf-siedler";
              home.packages = [ pkgs.k3d ];
              codex.enable = true;
            })
          ];
        };
        surface = let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
            ({ pkgs, ... }: {
              home.username = "pfsiedler";
              home.homeDirectory = "/home/pfsiedler";
              home.packages = [ pkgs.nixpkgs-fmt pkgs.jq pkgs.gnumake ];
            })
          ];
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.gnumake pkgs.nixfmt pkgs.shellcheck ];
        };
      });
}
