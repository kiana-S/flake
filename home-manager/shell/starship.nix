{ ... }:
{
  programs.starship.enable = true;

  programs.starship.settings = {

    format = "$directory$nix_shell$all$fill$cmd_duration$status$jobs$time$line_break$character";
    fill.symbol = " ";

    add_newline = true;

    battery.disabled = true;

    character =
      let char = "⮞"; charVi = "⮜";
      in {
        success_symbol = "[${char}](bold bright-green)";
        error_symbol   = "[${char}](bold bright-red)";
        vicmd_symbol   = "[${charVi}](bold bright-green)";
    };

    directory = {
      truncation_length = 6;
      truncation_symbol = "⋯ /";
      read_only = "  ";
      read_only_style = "cyan";
    };

    nix_shell = {
      format = "[$symbol]($style)";
      symbol = "❄️  ";
    };

    jobs = {
      format = "[$symbol$number]($style) ";
      symbol = " ";
      style = "green";
    };

    status = {
      disabled = false;
      format = "[\\($int\\)]($style) ";
    };

    time = {
      disabled = false;
      format = "[$time]($style) ";
      style = "dimmed cyan";
    };

    git_branch.style = "bold green";

    git_status = {
      format = "$stashed$ahead_behind$conflicted$deleted$renamed$staged$modified$untracked";

      conflicted = "[~$count ](red)";
      ahead = "[⇡$count ](cyan)";
      behind = "[⇣$count ](cyan)";
      diverged = "[⇕ ](cyan)";
      untracked = "[?$count ](cyan)";
      stashed = "[\\$$count ](cyan)";
      modified = "[!$count ](yellow)";
      staged = "[+$count ](yellow)";
      renamed = "[»$count ](yellow)";
      deleted = "[✘$count ](red)";
    };
  };
}
