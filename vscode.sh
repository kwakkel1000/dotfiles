#!/bin/bash
mkdir .vscode
pushd .vscode || exit
cp ~/dotfiles/rust/vscode-settings.json settings.json
popd || exit
