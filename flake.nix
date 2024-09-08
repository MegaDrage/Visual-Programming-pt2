{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {

      packages.x86_64-linux.default = pkgs.qt6Packages.callPackage ./task1 { };
      packages.x86_64-linux.task2 = pkgs.qt6Packages.callPackage ./task1 { };

      devShells.x86_64-linux.default = pkgs.mkShell {

        inputsFrom = [ self.packages.x86_64-linux.default ];
        buildInputs = with pkgs; [
          gdb
          qtcreator

          qt6.wrapQtAppsHook
          makeWrapper
          bashInteractive
        ];

        shellHook = ''
          bashdir=$(mktemp -d)
          makeWrapper "$(type -p bash)" "$bashdir/bash" "''${qtWrapperArgs[@]}"
          nohup qtcreator &
        '';
        # exec "$bashdir/bash"
      };
    };
}
