package main

import (
    "fmt"
    "time"
)

var days_of_week = [...]string{"Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"}

func get_days_of_week() [7]string {
	return days_of_week
}

func main() {
    now := time.Now()

    year, month, today := now.Year(), now.Month(), now.Day()

	// day, hour, minute, second, nanosecond
	first_of_month := time.Date(year, month, 1, 0, 0, 0, 0, time.Local)

	// years, months, days
	last_of_month := first_of_month.AddDate(0, 1, -1)

	fmt.Printf("     %s %d\n", month, year)

	for _, day := range get_days_of_week() {
		fmt.Printf("%s ", day)
	}
	fmt.Println()

	start_day_offset := (int(first_of_month.Weekday()) + 6) % 7

	for i := 0; i < start_day_offset; i++ {
		fmt.Print("   ")
	}

	highlight_start := "\033[47m\033[30m"
	highlight_end := "\033[0m"

	for day := 1; day <= last_of_month.Day(); day++ {
		if (day == today) {
			fmt.Printf("%s%2d%s ",highlight_start, day, highlight_end)
		} else { 
			fmt.Printf("%2d ", day) 
		}

		if (start_day_offset + day) % 7 == 0 {
			fmt.Println()
		}
	}

	if (start_day_offset + last_of_month.Day()) % 7 != 0 {
		fmt.Println()
	}
}
