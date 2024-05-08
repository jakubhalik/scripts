#!/bin/bash

if [ -d "$HOME/d" ]; then
	rm -rf ~/.zshrc
	cp ~/d/g/gh/scripts/.zshrc ~/.zshrc
else
	temp_zshrc=$(mktemp)
	sed 's|/d||g' ~/g/gh/scripts/.zshrc > "$temp_zshrc"
	rm -rf ~/.zshrc
	mv "$temp_zshrc" ~/.zshrc
fi
