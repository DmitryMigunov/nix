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
      k = "kubectl";
      kgp = "kubectl get pods";
      kgs = "kubectl get svc";
    };

    initContent = ''
      PROMPT='$(kube_ps1)'$PROMPT
    '';
  };
}
