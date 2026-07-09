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
      open = "handlr open";
      paste = "wl-paste";
      zed = "zeditor";
    };

    initContent = ''
      PROMPT='$(kube_ps1) '$PROMPT
      PATH="$PATH:$HOME/go/bin:$HOME/bin"

      tfa-targets() {
        local filter="$1"

        tf-targets \
          | rg "$filter" \
          | sed 's/^/-target=/' \
          | xargs -r terraform apply -auto-approve
      }
    '';
  };
}
