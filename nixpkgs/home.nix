{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pfsiedler";
  home.homeDirectory = "/home/pfsiedler";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

   home.packages = [
    pkgs.jetbrains-mono
    pkgs.niv
    pkgs.nodejs-16_x
    pkgs.yarn
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

   programs.git = {
    enable = true;

    userName = "Takuma Suzuki";
    userEmail = "pferd262@gmail.com";
    aliases = {
      br = "branch";
      co = "checkout";
      gl = "log --oneline --graph --decorate";
      ss = "stash store";
      sp = "stash pop";
      ca = "commit --amend";
    };
    extraConfig = {
      core.editor = "nano";
      init.defaultBranch = "master";
      merge = {
        conflictStyle = "diff3";
        ff = false;
      };
    };
  };

  programs.zsh = {
  enable = true;

  defaultKeymap = "emacs";

  dotDir = ".config/zsh";

  enableSyntaxHighlighting = true;

   shellAliases = {
      reload = "home-manager switch";
   };

  envExtra = ''
    if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh
    fi
  '';

  initExtra = ''
      export FPATH
    '';
  };

  programs.starship = {
    enable = true;

    settings = {
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      git_status = {
        conflicted = "🤼";
        modified = "📝";
        stashed = "💾";
        staged = "++\($count\)";
        renamed = "📛";
        deleted = "--\($count\)";
      };

      kubernetes = {
        disabled = false;
      };

      format = "$directory$git_branch$git_commit$git_state$git_metrics$git_status\n$character";

      right_format = "$all";
    };
  };
}
