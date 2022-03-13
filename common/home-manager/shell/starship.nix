{ ... }:
{
  programs.starship.enable = true;

  programs.starship.settings = {
    add_newline = true;

    battery.disabled = true;

    character =
      let char = "⮞"; charVi = "⮜";
      in {
        success_symbol = "[${char}](bold green)";
        error_symbol   = "[${char}](bold red)";
        vicmd_symbol   = "[${charVi}](bold green)";
    };

    directory = {
      truncation_length = 6;
      truncation_symbol = "⋯ /";
      read_only = " 🔒";
      read_only_style = "cyan";
    };

    nix_shell = {
      symbol = "❄️";
      format = "via [$symbol$name( \($state\))]($style) ";
    };

    git_status = {
      format = "$stashed$ahead_behind$conflicted$deleted$renamed$staged$modified$untracked";

      conflicted = "[~$count ](red)";
      ahead = "[⇡$count ](cyan)";
      behind = "[⇣$count ](cyan)";
      diverged = "[⇕ ](cyan)";
      untracked = "[?$count ](cyan)";
      stashed = "[\$$count ](cyan)";
      modified = "[!$count ](bright-yellow)";
      staged = "[+$count ](bright-yellow)";
      renamed = "[»$count ](bright-yellow)";
      deleted = "[✘$count ](red)";
    };
  };
}
