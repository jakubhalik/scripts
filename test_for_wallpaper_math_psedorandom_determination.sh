#!/bin/bash

# W=Wallpaper; C=Category; P=Per; CU=Current; S=second; ST=Start; O=Offset; I=Index; M=Middle; p_s_o=print_selection_order;

W_DIR="do/w"
WS=($(find "$W_DIR" -type f \( -name '*.jpg' -o -name '*.png' \)))
N_WS=${#WS[@]}
CS=16
W_P_C=$((N_WS / CS))

function p_s_o {
	CU_S=$(date +%S)
	ST_C=$((CU_S % CS))
	echo "Current second: $CU_S"
	echo "Starting category: $ST_C"
	for O in {0..15}; do
		C_I=$(( (ST_C + O) % CS ))
		M_I=$((W_P_C / 2))
		C_ST=$((C_I * W_P_C))
		W_I=$((C_ST + M_I))
		if [ $W_I -lt $N_WS ]; then
			echo "Category $C_I: Wallpaper Index: $W_I"
		fi
	done
}

p_s_o



