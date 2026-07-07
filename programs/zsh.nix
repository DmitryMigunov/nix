{...}: {
  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [
        "eza"
        "git"
        "kube-ps1"
        "terraform"
      ];
      theme = "essembeh";
    };

    shellAliases = {
      calc = "bc";
      copy = "wl-copy";
      k = "kubectl";
      kgp = "kubectl get pods";
      kgs = "kubectl get svc";
      paste = "wl-paste";
      zed = "zeditor";
    };

    initContent = ''
      PROMPT='$(kube_ps1) '$PROMPT
    '';
  };
}
