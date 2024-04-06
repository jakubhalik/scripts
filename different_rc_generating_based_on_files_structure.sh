#!/bin/bash

if [ -d "$HOME/Documents" ]; then
	rm -rf ~/.zshrc
	cp ~/Documents/git/github/Scripts/.zshrc ~/.zshrc
else
	temp_zshrc=$(mktemp)
	sed 's|/Documents||g' ~/git/github/Scripts/.zshrc > "$temp_zshrc"
	rm -rf ~/.zshrc
	mv "$temp_zshrc" ~/.zshrc
fi
