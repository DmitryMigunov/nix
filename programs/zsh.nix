{...}: {
  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "kube-ps1"
      ];
      theme = "cloud";
    };
  };
}
