#!/bin/bash

ZSHRC="$HOME/.zshrc"
BASHRC="$HOME/.bashrc"

START_C="# Aliases over .zshrc and .bashrc being automatically the same start"
END_C="# Aliases over .zshrc and .bashrc being automatically the same end"

log() {
	echo "[DEBUG] $1"
}

log "Script starting"

for FILE in "$ZSHRC" "$BASHRC"; do
	if ! grep "$START_C" "$FILE"; then
		log "Start comment not found in $FILE"
		exit 1
	elif ! grep "$END_C" "$FILE"; then
		log "End comment not found in $FILE"
	elif [ "$(grep -c "$START_C" "$FILE")" -ne 1 ]; then
		log "Multiple end comments found in $FILE"
		exit 1
	elif [ "$(grep -c "$END_C" "$FILE")" -ne 1 ]; then
		log "Multiple end comments found in $FILE"
		exit 1
	fi
done

log "Script continuing after for loop debug of if comments are appropriately found"

log "Extracting aliases from $ZSHRC"

zsh_aliases=$(sed -n "/$START_C/,/$END_C/p" "$ZSHRC")

echo "$zsh_aliases"

log "Extracted aliases from .zshrc"

log "Extracting the part before the alias block in $BASHRC"

sed "/$START_C/,/$END_C/d" "$BASHRC" > /tmp/bashrc_part1

cat /tmp/bashrc_part1

log "Extracted the part before the alias block"

log "Extracting the part after the alias block in $BASHRC"

sed -n "/$END_C/,\$p" "$BASHRC" | tail -n +2 > /tmp/bashrc_part3

cat /tmp/bashrc_part3

log "Extracted the part after the alias block"

log "Concatenating the parts together with the new aliases"

	cat /tmp/bashrc_part1;

	log "zsh aliases: ";

       	echo "$zsh_aliases";

	log "end comment: ";

	echo "$END_C";

       	cat /tmp/bashrc_part3



{

	cat /tmp/bashrc_part1;

       	echo "$zsh_aliases";

       	cat /tmp/bashrc_part3

} > /tmp/bashrc_full



cat /tmp/bashrc_full

log "Concatenated the parts together"

log "Replacing the original $BASHRC with the modified version"

mv /tmp/bashrc_full "$BASHRC"

log "Cleaning up temporary files"

rm /tmp/bashrc_part1 /tmp/bashrc_part3

echo -e "\n\n\n\n\n\nNEW .bashrc FILE:\n\n\n\n\n\n\n"
cat ~/.bashrc

log "Script completed successfully"

