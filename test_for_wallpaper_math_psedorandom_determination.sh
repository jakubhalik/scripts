#!/bin/bash

# W=Wallpaper; C=Category; P=Per; CU=Current; S=second; ST=Start; O=Offset; I=Index; M=Middle; p_s_o=print_selection_order; L=Logged;
# LE=Left; R=Right; E=End;

W_DIR="do/w"
WS=($(find "$W_DIR" -type f \( -name '*.jpg' -o -name '*.png' \)))
N_WS=${#WS[@]}
CS=16
W_P_C=$((N_WS / CS))
L=()

function log_ws {
	local le=$1
	local r=$2
	if [[ $le -le $r ]]; then
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
	local c_st=$((ST_C * W_P_C))
	local c_e=$(((ST_C + 1) * W_P_C - 1))
	if [[ $c_e -ge $N_WS ]]; then
		c_e=$((N_WS - 1))
	fi
	log_ws $c_st $c_e
}

p_s_o

