{ stdenv, lib, ... }:

stdenv.mkDerivation rec {
  pname = "bCNC-nix";
  version = "0.1.0";

  src = ./.;

  meta = with lib; {
    description = "TODO: fill me in";
    homepage = "https://github.com/eraserhd/bCNC-nix";
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}