#!/bin/bash
mkdir .vscode
pushd .vscode || exit
cp ~/dotfiles/vscode-settings.json settings.json
popd || exit
