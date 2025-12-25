{ stdenv, lib, python312Packages, fetchFromGitHub, fetchPypi }:

let
  pythonPackages = python312Packages;

  shxparser = pythonPackages.buildPythonPackage rec {
    pname = "shxparser";
    version = "0.0.2";

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-hUHkvOYodoIsk/OVnn9pCe8b+DUmkbNDus2qqbkv8nA=";
    };

    pyproject = true;
    build-system = with pythonPackages; [
      setuptools
      wheel
    ];
  };

in pythonPackages.buildPythonApplication rec {
  pname = "bCNC";
  version = "df97b36f0b2fa91c6774a7c18da6df226537226e";

  src = fetchFromGitHub {
    owner = "vlachoudis";
    repo = "bCNC";
    rev = version;
    hash = "sha256-vMBBjVH3xemo55wjcpFzCkkE0vfcC0EBe2HIFC8XQ1s=";
  };

  patches = [
    ./opencv-pi-version.diff
  ];

  pyproject = true;
  build-system = with pythonPackages; [
    setuptools
    wheel
  ];

  # FIXME: Add darwin-specific dependencies
  dependencies = with pythonPackages; [
    tkinter
    numpy
    pyserial
    svgelements
    shxparser
    pillow
    #python-imaging-tk ??
    opencv-python
    scipy
    tkinter-gl
  ];

  meta = with lib; {
    description = "GRBL CNC command sender, autoleveler and g-code editor";
    homepage = "https://github.com/eraserhd/bCNC-nix";
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}
