#!/bin/bash
# This script does not actually work as it should, not even close really, but right now I do not need it anymore, maybe I will never need it, but I will keep the WIP here just for case.
# W=Wallpaper; C=Category; P=Per; CU=Current; S=second; ST=Start; O=Offset; I=Index; M=Middle; p_s_o=print_selection_order; L=Logged;
# LE=Left; R=Right; E=End;

W_DIR="do/w"
echo "Wallpaper directory: $W_DIR"
WS=($(find "$W_DIR" -type f \( -name '*.jpg' -o -name '*.png' \)))
echo "Wallpapers: $WS"
N_WS=${#WS[@]}
echo "There are $N_WS wallpapers"
CS=16
echo "Gonna be dividing into $CS categories"
W_P_C=$((N_WS / CS))
echo "There is $W_P_C wallpapers per category"
L=()
echo "Logs $L"

function log_ws {
	echo "Executing the function of logging wallpapers"
	local le=$1
	echo "Left: $le"
	local r=$2
	echo "Right: $r"
	if [[ $le -le $r ]]; then
		echo "Left: $le"
		echo "Right: $r"
		local m=$(( (le + r) / 2 ))
		echo "Middle: $m"
		if [[ ! " ${L[@]} " =~ " ${m} " ]]; then
			echo "${L[@]}"
			echo "${m}"
			echo "Logging wallpaper index: $m from range $le to $r"
			L+=($m)
			echo "Logs: $L"
			echo "Left: $le"
			echo "Right: $r"
			echo "Middle: $m"
		fi
		log_ws $le $((m - 1))
		echo "Executing the function of logging wallpapers recursively in the function of logging the wallpapers for the 1st time"
		echo "Logs: $L"
		echo "Left: $le"
		echo "Right: $r"
		echo "Middle: $m"
		log_ws $((m + 1)) $r
		echo "Executing the function of logging wallpapers recursively in the function of logging the wallpapers for the 2nd time"
		echo "Logs: $L"
		echo "Left: $le"
		echo "Right: $r"
		echo "Middle: $m"
	fi
}

function p_s_o {
	local le_c=$1
	echo "Left category: $le_c"
	local r_c=$2
	echo "Right category: $r_c"
	if [[ $le_c -le $r_c ]]; then
		local m_c=$((  (le_c + r_c) / 2 ))
		echo "Middle category: $m_c"
		local c_le=$((m_c * W_P_C))
		echo "Wallpapers per category: $W_P_C"
		echo "Left wallpaper of the category: $c_le"
		local c_r=$(((m_c + 1) * W_P_C - 1))
		echo "Wallpapers per category: $W_P_C"
		echo "Right of the category: $c_r"
		if [[ $c_r -ge $N_WS ]]; then
			echo "There are $N_WS wallpapers"
			c_r=$((N_WS - 1))
			echo "Right of the category: $c_r"
		fi
		echo "Left wallpaper of the category: $c_le"
		echo "Right of the category: $c_r"
		echo "Calling wallpaper logging function from the print selection order function"
		log_ws $c_le $c_r
		echo "Left category: $le_c"
		echo "Left wallpaper of the category: $c_le"
		echo "Right of the category: $c_r"
		echo "Middle category: $m_c"
		echo "Executing the print selection order function recursively from the print selection order function for the 1st time"
		p_s_o $le_c $((m_c - 1))
		echo "Right category: $r_c"
		echo "Left wallpaper of the category: $c_le"
		echo "Right of the category: $c_r"
		echo "Middle category: $m_c"
		echo "Executing the print selection order function recursively from the print selection order function for the 2nd time"
		p_s_o $((m_c + 1)) $r_c
	fi
}

echo "Categories: $CS"
echo "Categories - 1: $CS"
echo "Executing print selection order function"
p_s_o 0 $((CS -1))
echo "All wallpapers have been logged."

