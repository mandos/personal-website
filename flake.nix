{
  description = "My personal web site";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in
    {

      # packages.x86_64-linux.default =
      #   let
      #     build-website = pkgs.writeShellApplication
      #       {
      #         name = "build-website";
      #         runtimeInputs = with pkgs; [ emacs29-nox ];
      #         text = builtins.readFile ./scripts/build.sh;
      #       };
      #     publish = pkgs.writeTextFile {
      #       name = "emacs-publish";
      #       text = builtins.readFile ./scripts/publish.el;
      #       destination = "/bin/publish.el";
      #     };
      #   in
      #   pkgs.symlinkJoin {
      #     name = "dupa";
      #     paths = [ build-website publish ];
      #   };

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          # self.packages.x86_64-linux.default
          (import ./jekyll/shell.nix { inherit pkgs; })
          pkgs.hugo
        ];
      };

      devShells.x86_64-linux.terraform = pkgs.mkShell {
        buildInputs = with pkgs; [
          # pkgs.cdkf
          nodePackages_latest.cdktf-cli
          terraform
          terragrunt
          terraform-ls
          go
          gopls
          gotools
          go-tools
          go-outline
          gopkgs
          godef
          golint
          watchexec
        ];
      };


    };
}
