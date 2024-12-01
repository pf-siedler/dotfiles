{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    codex.url = "git+ssh://git@github.com/herp-inc/codex";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    vscode-server.url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, nixos-wsl, vscode-server, codex, ... }@inputs:
    {
      homeConfigurations = {
        beelink =
          let
            system = "x86_64-linux";
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs; };
            modules = [
              ./home.nix
              ./starship-windows-terminal.nix
              ({ pkgs, ... }: {
                home.username = "pfsiedler";
                home.homeDirectory = "/home/pfsiedler";
                programs.vscode.enable = pkgs.lib.mkForce false;
                nix = {
                  package = pkgs.nixFlakes;
                  extraOptions = ''
                    experimental-features = nix-command flakes
                    extra-trusted-users = pf-siedler
                  '';
                };
              })
            ];
          };
        herp =
          let
            system = "aarch64-darwin";
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          in
          home-manager.lib.homeManagerConfiguration {
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
                nix = {
                  package = pkgs.nixFlakes;
                  extraOptions = ''
                    experimental-features = nix-command flakes
                    extra-trusted-users = pf-siedler
                  '';
                };
              })
            ];
          };
        surface =
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
                home.packages = [ pkgs.nixpkgs-fmt pkgs.jq pkgs.gnumake ];
                nix = {
                  package = pkgs.nixFlakes;
                  extraOptions = ''
                    experimental-features = nix-command flakes
                    extra-trusted-users = pf-siedler
                  '';
                };
              })
            ];
          };
      };
      nixosConfigurations = {
        # for WSL NixOS
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            vscode-server.nixosModules.default
            ./wsl.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nixos =
                ({ pkgs, ... }: {
                  imports = [
                    ./home.nix
                    ./starship-windows-terminal.nix
                  ];
                  programs.vscode.enable = pkgs.lib.mkForce false;
                });
            }
            ({pkgs, ...}: {
              nix.settings.experimental-features = [ "nix-command" "flakes" ];
              programs.zsh.enable = true;
              users.defaultUserShell = pkgs.zsh;
            })
          ];
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.gnumake pkgs.nixpkgs-fmt pkgs.shellcheck ];
        };
      });
}
