#this justfile is generated

# print the just commands
default:
    just --list

alias r := run

# run the software
run:
    npm start

alias p := pre-commit-all

# launch all the pre-commit hooks on all the files
pre-commit-all:
    pre-commit run --all-files

alias br := build-release

# build the software in release mode
build-release:
    npm run build

alias nc := nix-checks

# launch all the checks in a flake if present and nix is available
nix-checks:
    if nix --version; then     nix flake check --no-pure-eval --extra-experimental-features flakes --extra-experimental-features nix-command;  else     echo nix is not available, so the nix checks are skipped;   fi

alias a := all

# launch all the steps
all: pre-commit-all build-release nix-checks

alias w := watch

# launch all the steps (can be very intense on cpu)
watch:
    watchexec just    pre-commit-all
