#this justfile is generated

default:
  just --list




run:
  npm start




pre-commit-all:
  pre-commit run --all-files





build-release:
  npm run build

all:    pre-commit-all build-release

