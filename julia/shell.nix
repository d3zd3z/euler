# Shell configuration for Zephyr work
# This currently requires the unstable channel for the newest tools.
{ pkgs ? import <unstable> {} }:
let
  packages = with pkgs; [
    julia
  ];
in
pkgs.mkShell {
  nativeBuildInputs = packages;
}
