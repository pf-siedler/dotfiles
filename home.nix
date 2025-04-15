{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [ "vscode" ];

  home.packages =
    [ pkgs.yq pkgs.jwt-cli pkgs.colordiff pkgs.shellcheck pkgs.docker-client ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      source ${pkgs.vimPlugins.vim-plug}/plug.vim
      source ${./vim/plugins.vim}
      set encoding=utf-8
      set autoindent
      set smartindent
      set number

      inoremap <C-a> <C-o>^
      inoremap <C-e> <C-o>$
    '';
  };

  programs.vscode = { enable = true; };

  programs.git = {
    enable = true;

    userName = "Takuma Suzuki";
    userEmail = "pferd262@gmail.com";
    aliases = {
      br = "branch";
      co = "checkout";
      gl = "log --oneline --graph --decorate";
      ss = "stash";
      sp = "stash pop";
      sl = "stash list";
      cm = "commit";
      cma = "commit --amend";
      fixup = "commit --fixup HEAD";
      fx = "commit --fixup HEAD";
      squash = "commit --squash HEAD";
      sq = "commit --squash HEAD";
      pukk = ''!echo "（○｀3´○）ぷきゅ〜！！" && git pull'';
      latest = "!git --no-pager branch --sort=authordate | tail -n 5";
      delete-merged =
        "!git branch --merged | grep -vE \\\\\\*\\|master | xargs -I % git branch -d %";
    };
    extraConfig = {
      core.editor = pkgs.lib.getExe pkgs.neovim;
      init.defaultBranch = "master";
      pull = { ff = "only"; };
      push = { default = "current"; };
      merge = {
        conflictStyle = "diff3";
        ff = false;
      };
      rebase = {
        autosquash = true;
        autostash = true;
      };
    };
    ignores =
      [ ".DS_Store" ".direnv" ".vscode" "node_modules/" ".env" "result/" ];
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      aliases = {
        pc = "pr create --web";
        pv = "pr view --web";
        b = "browse";
      };
    };
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;

    defaultKeymap = "emacs";

    dotDir = ".config/zsh";

    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
      k = "kubectl";
      devinit = "nix flake init -t github:pf-siedler/flake-templates#devshell";
      cdg = ''cd "$(git rev-parse --show-toplevel)"'';
    };

    history = {
      extended = true;
      path = "${config.xdg.dataHome}/zsh/.zsh_history";
    };

    envExtra = ''
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix

      ## start lima-docker if it's stopped
      #if limactl list | grep -q "lima-docker\s*Stopped"; then
      #  limactl start lima-docker
      #fi
    '';

    initExtra = ''
      export FPATH

      . ${./zsh/history.zsh}
      source <(kubectl completion zsh)
    '';
  };

}
