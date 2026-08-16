{
  description = "IosevkaIP custom font";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.stdenvNoCC.mkDerivation {
        pname = "iosevka-ip";
        version = "unstable";
        src = ./assets;
        dontUnpack = true;

        installPhase = ''
          runHook preInstall
          mkdir -p $out/share/fonts/truetype/IosevkaIP
          cp $src/*.ttf $out/share/fonts/truetype/IosevkaIP/
          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description = "Custom Iosevka build (IosevkaIP)";
          license = licenses.ofl;
          platforms = platforms.all;
        };
      };
    });
  };
}
