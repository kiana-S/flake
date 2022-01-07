{ ... }:
{
  programs.starship.enable = true;

  programs.starship.settings = {
    add_newline = true;
    
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
  };
}
