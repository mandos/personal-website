{ pkgs, ... }:
let
  env = pkgs.bundlerEnv {
    name = "jekyll-bundler-env";
    # inherit pkgs.ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
[
  env
  pkgs.ruby_3_2
  pkgs.bundix
]
