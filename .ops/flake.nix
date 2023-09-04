{
  description = "zoonect/ventoventures-app";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs-unstable, flake-utils, ... } @ args: flake-utils.lib.eachSystem ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"] (system: let
    pkgs = import nixpkgs-unstable { inherit system; };

    erlangVersion = "erlang_26";
    erlang = pkgs.beam.interpreters.${erlangVersion};

    elixirVersion = "elixir_1_15";
    elixir = pkgs.beam.packages.${erlangVersion}.${elixirVersion};

    nodejsVersion = "nodejs-18_x";
    nodejs = pkgs.${nodejsVersion};

    inherit (pkgs.lib) optional optionals;

    fileWatchers = with pkgs; (
      optional stdenv.isLinux [libnotify inotify-tools] ++
      optional stdenv.isDarwin [terminal-notifier] ++ (with darwin.apple_sdk.frameworks; [CoreFoundation CoreServices])
    );
  in rec {
    devShells.default = nixpkgs-unstable.legacyPackages.${system}.mkShell {
      buildInputs = [
        erlang
        elixir
        nodejs
      ]
      ++ (with pkgs; [
        (yarn.override { nodejs = nodejs; })
      ])
      ++ fileWatchers;

      shellHook = ''
        export HEX_HOME="$PWD/.nix/hex"
        mkdir -p $HEX_HOME
        export MIX_HOME="$PWD/.nix/mix"
        mkdir -p $MIX_HOME

        export PATH="$MIX_HOME/bin:$MIX_HOME/escripts:$HEX_HOME/bin:$PATH"
        export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$PWD/.nix/history\"'"

        mix local.rebar --if-missing --force
        mix local.hex --if-missing --force
      '';
    };
  });
}
