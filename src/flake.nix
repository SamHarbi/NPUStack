{
  description = "Podman and Podman Compose Prod (and Dev) environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; 
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          podman
          podman-compose
          catatonit # Required backend dependency for Podman networking/entrypoints
        ];

        shellHook = ''
          export XDG_RUNTIME_DIR=$(mktemp -d)
          export PODMAN_USERNS=keep-id
          podman compose up
        '';
      };
    };
}
