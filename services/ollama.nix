{...}: {
  services.ollama = {
    enable = true;
    acceleration = null;
    host = "127.0.0.1";
    port = 11434;
  };
}
