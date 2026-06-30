{ pkgs, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      screenshots = true;
      effect-blur = "15x10";
      color = "00000099";
      indicator = true;
      clock = true;
      font-size = 28;
    };
  };
}
