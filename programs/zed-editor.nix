{...}: {
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "toml" "rust" "lua"];
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
