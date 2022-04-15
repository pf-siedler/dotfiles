{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

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
    pkgs.niv
    pkgs.nodejs-16_x
    pkgs.yarn
    pkgs.jq
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
        success_symbol = "[=>](bold green)";
        error_symbol = "[=>](bold red)";
      };

      aws = {
        format = ''[$symbol($profile)(\($region\))(\[$duration\])]($style)'';
        symbol = "🅰 ";
        region_aliases = {
          ap-northeast-1 = "東京";
          ap-northeast-3 = "大阪";
          us-west-2 = "Oregon";
        };
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
        format = "[$symbol$context( \($namespace\))]($style) ";
      };

      nix_shell = {
        format = "[$symbol$state( \($name\))]($style)";
        symbol = " ";
      };

      nodejs.format = "[$symbol($version )]($style)";

      time = {
        disabled = false;
        format = "[⏲️ $time]($style)";
        style = "bold fg:black bg:yellow";
        time_format = "%H:%M";
      };

      format = "$directory$git_branch$git_commit$git_state$git_metrics$git_status\n$character";

      right_format = "$all";

      continuation_prompt = "[…](yellow) ";
    };
  };
}
