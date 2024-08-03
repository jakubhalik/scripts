#!/bin/bash

revert_date() {
    sudo date -s "$current_date"
    echo "Date reverted back to: $current_date"
}

current_date=$(date)

sudo date -s "2023-12-15"

go run cal.go

revert_date
