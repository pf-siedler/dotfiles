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
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "vscode"
  ];

  home.packages = [
    pkgs.yq
    pkgs.jwt-cli
    pkgs.colordiff
    pkgs.shellcheck
    pkgs.docker-client
    pkgs.terraform_1
  ];

  programs.direnv = {
    enable = true;
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

  programs.vscode = {
    enable = true;
  };

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

    defaultKeymap = "emacs";

    dotDir = ".config/zsh";

    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
      k = "kubectl";
      devinit = "nix flake init -t github:pf-siedler/flake-templates#devshell";
      cdg = "cd \"$(git rev-parse --show-toplevel)\"";
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

  programs.starship = {
    enable = true;

    settings = {
      character = {
	success_symbol = "[ 🙂>](bold green)";
        error_symbol = "[ 🙃>](bold red)";
      };

      aws = {
        format = "[$symbol($profile)(\\($region\\))(\\[$duration\\])]($style)";
        symbol = "🅰 ";
        region_aliases = {
          ap-northeast-1 = "東京";
          ap-northeast-3 = "大阪";
          us-west-2 = "Oregon";
        };
      };

      cmd_duration.format = "🐢 [$duration]($style) ";

      git_status = {
        conflicted = "🤼";
        modified = "📝";
        stashed = "💾";
        diverged = "↕️";
        ahead = "⬆️";
        behind = "⬇️";
        up_to_date = "🈁";
        staged = "++($count)";
        renamed = "📛";
        deleted = "--($count)";
      };

      kubernetes = {
        disabled = false;
        format = "[$symbol$context( ($namespace))]($style) ";
      };

      nix_shell = {
        format = "[$symbol$state( ($name))]($style) ";
        symbol = " ";
      };

      nodejs.format = "[$symbol($version )]($style) ";

      time = {
        disabled = false;
        format = "[⏲️ $time]($style)";
        style = "bold fg:black bg:yellow";
        time_format = "%H:%M";
      };

      format = ''$directory$git_branch$git_commit$git_state$git_metrics$git_status$cmd_duration'';

      right_format = "$all";

      continuation_prompt = "[…](yellow) ";
    };
  };
}
