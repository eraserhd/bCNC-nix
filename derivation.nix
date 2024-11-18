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

    build-system = with pythonPackages; [
      setuptools
      wheel
    ];
  };

in pythonPackages.buildPythonApplication rec {
  pname = "bCNC";
  version = "0b3ad63e32d2ef8ffbe1a14345a6821d773f6067";

  src = fetchFromGitHub {
    owner = "vlachoudis";
    repo = "bCNC";
    rev = version;
    hash = "sha256-OMILyZlqpozW8RXUQnlNLAUubbYjC+30CDBX5pafTzw=";
  };

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
  ];

  meta = with lib; {
    description = "GRBL CNC command sender, autoleveler and g-code editor";
    homepage = "https://github.com/eraserhd/bCNC-nix";
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}
