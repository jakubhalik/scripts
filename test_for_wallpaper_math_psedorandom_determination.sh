#!/bin/bash

# W=Wallpaper; C=Category; P=Per; CU=Current; S=second; ST=Start; O=Offset; I=Index; M=Middle; p_s_o=print_selection_order; L=Logged;

W_DIR="do/w"
WS=($(find "$W_DIR" -type f \( -name '*.jpg' -o -name '*.png' \)))
N_WS=${#WS[@]}
CS=16
W_P_C=$((N_WS / CS))

L=()

function p_s_o {
	while [ ${#L[@]} -lt $N_WS ]; do
		CU_S=$(date +%S)
		ST_C=$(((CU_S * CS / 60) % CS))
		echo "Current second: $CU_S"
		echo "Starting category: $ST_C"
		for O in {0..15}; do
			C_I=$(( (ST_C + O) % CS ))
			M_I=$((W_P_C / 2))
			C_ST=$((C_I * W_P_C))
			W_I=$((C_ST + M_I))
			if [ $W_I -lt $N_WS ]; then
				if [[ ! " ${L[@]} " =~ " ${W_I} " ]]; then
					echo "Category $C_I: Wallpaper Index: $W_I"
					L+=($W_I)
				fi
			fi
		done
		sleep 1
	done
	echo "All wallpapers have been logged."
}

p_s_o

