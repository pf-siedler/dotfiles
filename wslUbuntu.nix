{ pkgs, inputs, ... }:
let
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config = { allowUnfree = true; };
  };
  # WSL 上の CLI ツール (gh, git, cargo doc --open 等) がブラウザを開こうとした際に、
  # Linux 側のブラウザではなく Windows ホストの既定ブラウザを起動させるためのラッパー。
  # explorer.exe は Windows の ShellExecute 経由で URL/ファイルの既定アプリを起動する。
  # (成功時でも exit code 1 を返すことがある既知の挙動のため `|| true` で無視する)
  wslOpen = pkgs.writeShellScriptBin "wsl-open" ''
    set -euo pipefail
    target="$1"
    case "$target" in
      http://*|https://*) ;;
      *) target=$(wslpath -w "$target" 2>/dev/null || printf '%s' "$target") ;;
    esac
    explorer.exe "$target" || true
  '';
in
{
  home.username = "pfsiedler";
  home.homeDirectory = "/home/pfsiedler";
  programs.vscode.enable = pkgs.lib.mkForce false;
  programs.zsh.enable = pkgs.lib.mkForce false;
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = ["ignoreboth"];
    historySize = 10000;
    historyFileSize = 20000;
  };
  programs.direnv.enableBashIntegration = true;
  home.packages = [
    unstablePkgs.claude-code
    wslOpen
    (pkgs.writeShellScriptBin "xdg-open" ''exec ${wslOpen}/bin/wsl-open "$@"'')
  ];
  # $BROWSER を見るツール(python webbrowser, node の open, gh, git 等)はこちらを優先する
  home.sessionVariables.BROWSER = "wsl-open";
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-trusted-users = pf-siedler
    '';
  };
}
