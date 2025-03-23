{
  description = "A Flake template for developing games with Ebitengine.";

  outputs =
    { self }:
    {
      templates = {
        ebiten = {
          path = ./nix;
          description = "Ebitengine template";
          welcomeText = ''
            # Getting started
            - Run `nix develop`
            - Run `go run cmd/hello/main.go`
          '';
        };
        defaultTemplate = self.templates.ebiten;
      };
    };
}
