# nix-ebiten flake template

This flake contains a template to use for developing games with [Ebitengine](https://ebitengine.org/).

## Usage

Create a new flake in the current directory using this template:
```sh
nix flake init -t github:shellhazard/nix-ebiten
```

Enter a development shell:
```sh
nix develop
```

Confirm it all works by running the example program:
```sh
go run cmd/hello/main.go
```

Use Nix to build an output derivation:
```sh
nix build
```

## Notes

If you're new to Nix, there's a few things may catch you off guard:
- Flakes are still experimental. If you haven't used them before, you'll need to [enable flakes in your environment](https://wiki.nixos.org/wiki/Flakes).
- When your dependencies change, the `vendorHash` in your `flake.nix` will need to be updated. The easiest way to do this is to set it to an empty string, then run `nix build` and use the hash provided on error. For more information, [see the relevant documentation in nixpkgs](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/go.section.md#vendorhash-var-go-vendorhash).

