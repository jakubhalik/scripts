#!/bin/bash

# W=Wallpaper; C=Category; P=Per; CU=Current; S=second; ST=Start; O=Offset; I=Index; M=Middle; p_s_o=print_selection_order; L=Logged;
# LE=Left; R=Right;

W_DIR="do/w"
WS=($(find "$W_DIR" -type f \( -name '*.jpg' -o -name '*.png' \)))
N_WS=${#WS[@]}
CS=16
W_P_C=$((N_WS / CS))
L=()

function log_ws {
	local le=$1
	local r=$2
	if [[ $le -le $end ]]; then
		local m=$(( (le + r) / 2 ))
		if [[ ! " ${L[@]} " =~ " ${m} " ]]; then
			echo "Logging wallpaper index: $m from range $le to $r"
			L+=($m)
		fi
		log_ws $le $((m - 1))
		log_ws $((m + 1)) $r
	fi
}

function p_s_o {
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
}

p_s_o

