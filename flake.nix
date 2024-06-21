{
  inputs = {
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    nixpkgs,
    systems,
    ...
  } @ inputs: let
    # Set the Erlang version
    erlangVersion = "erlang";
    # Set the Elixir version
    elixirVersion = "elixir";

    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (
        system:
          f (import nixpkgs {
            inherit system;
            overlays = [
              (final: _: let
                erlang = final.beam.interpreters.${erlangVersion};
                beamPackages = final.beam.packages.${erlangVersion};
                elixir = beamPackages.${elixirVersion};
              in {
                inherit erlang elixir;
                inherit (beamPackages) elixir-ls hex;
              })
            ];
          })
      );
  in {
    devShells = eachSystem (
      pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            erlang
            elixir
            inotify-tools
          ];
        };
      }
    );
  };
}
