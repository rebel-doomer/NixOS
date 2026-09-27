/*
# example 1
{
  inputs,
  pkgs,
  ...
}:
let
  inherit (pkgs) system;
  inherit (inputs)
    nil
    nixpkgs-unstable
    ;
  unstable = import nixpkgs-unstable { inherit system; };
in
{
  nixpkgs.overlays = [
    # Allow importing packages from nixpkgs-unstable under pkgs.unstable
    (_: prev: {
      inherit unstable;
    })
    (import ./discord.nix)
    (import ./substitute-all-rec)
    (import ./try-import)
    (_: _: { nil = nil.packages.${system}.nil; })
    (_: prev: {
      # see https://github.com/NixOS/nixpkgs/issues/488689
      inherit (unstable) inetutils;
    })
  ];
}

# example 2 below
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };
  # inputs.niri.overlays.niri;
  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
  no-system =
    prev:
    let
      assertNoSystem =
        if builtins.hasAttr "system" prev then
          throw "Error: 'system' attribute is deprecated. Use 'stdenv.hostPlatform.system' instead."
        else
          prev;

    in
    assertNoSystem;
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
*/