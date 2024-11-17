{ config, pkgs, ... }: {
  programs.starship = {
    enable = true;

    settings = {
      character = {
        success_symbol = "[ 🙂 >](bold green)";
        error_symbol = "[ 🙃 >](bold red)";
      };

      line_break = { disabled = true; };

      aws = {
        format = "[$symbol($profile)(\\($region\\))(\\[$duration\\])]($style)";
        symbol = "🅰 ";
        region_aliases = {
          ap-northeast-1 = "東京";
          ap-northeast-3 = "大阪";
          us-west-2 = "Oregon";
        };
      };

      git_status = {
        conflicted = "🤼 ";
        modified = "📝 ";
        stashed = "💾 ";
        diverged = "↕️";
        ahead = "↑";
        behind = "↓";
        up_to_date = "🈁 ";
        staged = "++($count)";
        renamed = "📛 ";
        deleted = "--($count)";

        format = "([$all_status$ahead_behind]($style) )";
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

      continuation_prompt = "[…](yellow) ";

      format = ''
        $all
        $directory$git_branch$git_commit$git_state$git_metrics$git_status
        $time$character
      '';
    };
  };
}
