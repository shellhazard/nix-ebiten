{
  description = "A Flake template for developing games with Ebitengine.";

  outputs =
    { self }:
    {
      templates = {
        default = {
          path = ./template;
          description = "Ebitengine template";
          welcomeText = ''
            # Getting started
            - Run `nix develop`
            - Run `go run cmd/hello/main.go`
          '';
        };
      };
    };
}
