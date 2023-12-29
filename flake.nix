{
  description = "My personal web site";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      packages.x86_64-linux.default =
        let
          build-website = pkgs.writeShellApplication
            {
              name = "build-website";
              runtimeInputs = with pkgs; [ emacs29-nox ];
              text = builtins.readFile ./scripts/build.sh;
            };
          publish = pkgs.writeTextFile {
            name = "emacs-publish";
            text = builtins.readFile ./scripts/publish.el;
            destination = "/bin/publish.el";
          };
        in
        pkgs.symlinkJoin {
          name = "dupa";
          paths = [ build-website publish ];
        };

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          self.packages.x86_64-linux.default
          (import ./jekyll/shell.nix { inherit pkgs; })
        ];
      };

      # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      devShells.x86_64-linux.terraform = pkgs.mkShell {
        buildInputs = [
          # pkgs.cdkf
        ];
      };


    };
}
