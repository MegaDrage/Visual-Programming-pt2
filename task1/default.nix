{ stdenv, qtbase, full, cmake, wrapQtAppsHook }:
stdenv.mkDerivation {
  pname = "task-1-qt";
  version = "1.0";

  src = ./.;

  buildInputs = [ qtbase full ];

  nativeBuildInputs = [ cmake wrapQtAppsHook ];

  # If the CMakeLists.txt has an install step, this installPhase is not needed.
  # The Qt default project however does not have one.
  installPhase = ''
    mkdir -p $out/bin
    cp qt-example $out/bin/
  '';
}
