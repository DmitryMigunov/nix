{...}: {
  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "eza"
        "kube-ps1"
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
