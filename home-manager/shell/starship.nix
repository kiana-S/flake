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
      before_repo_root_style = "bold blue";
      repo_root_style = "bold blue";
    };

    nix_shell = {
      format = "[$symbol \\($state\\) ]($style)";
      symbol = "❄️";
    };

    jobs = {
      format = "[$symbol$number]($style) ";
      symbol = " ";
      style = "green";
    };

    status = {
      disabled = false;
      pipestatus = true;
      format = "[\\($int\\)]($style) ";
      pipestatus_segment_format = "$int";
      pipestatus_format = "[\\($pipestatus\\)]($style) ";
    };

    time = {
      disabled = false;
      format = "[$time]($style) ";
      style = "dimmed cyan";
    };

    git_branch.style = "bold bright-green";

    git_status = {
      format = "$stashed$ahead_behind$conflicted$deleted$renamed$staged$modified$untracked";

      conflicted = "[~$count ](bright-red)";
      ahead = "[⇡$count ](bright-cyan)";
      behind = "[⇣$count ](bright-cyan)";
      diverged = "[⇕ ](bright-cyan)";
      untracked = "[?$count ](bright-cyan)";
      stashed = "[\\$$count ](bright-cyan)";
      modified = "[!$count ](yellow)";
      staged = "[+$count ](yellow)";
      renamed = "[»$count ](yellow)";
      deleted = "[✘$count ](bright-red)";
    };
  };
}
