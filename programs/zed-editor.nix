{...}: {
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "toml" "rust" "lua" "perl"];
    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
      hour_format = "hour24";
    };
  };
}
