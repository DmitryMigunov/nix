{...}: {
  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "kube-ps1"
      ];
      theme = "essembeh";
    };

    initContent = ''
      PROMPT='$(kube_ps1)'$PROMPT
    '';
  };
}
