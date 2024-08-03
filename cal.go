package main

import (
    "fmt"
    "time"
)

var days_of_week = [...]string{"Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"}

func get_days_of_week() [7]string {
	return days_of_week
}

func is_holiday(day int, month time.Month) bool {
	holidays := map[time.Month][]int{
		time.January:   {1},
		time.March:     {29},
		time.April:     {1},
		time.May:       {1, 8},
		time.July:      {5, 6},
		time.September: {28},
		time.October:   {28},
		time.November:  {17},
		time.December:  {24, 25, 26},
	}

	for _, d := range holidays[month] {
		if d == day {
			return true
		}
	}

	return false
}

func is_birthday(day int, month time.Month) bool {
	birthdays := map[time.Month][]int{
		time.January:   {5},
		time.August:	{23},
	}

	for _, d := range birthdays[month] {
		if d == day {
			return true
		}
	}

	return false
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

	white_background_black_text_highlight_start := "\033[47m\033[30m"
	cyan_background_black_text_highlight_start := "\033[46m\033[30m"
	red_background_black_text_highlight_start := "\033[41m\033[30m"

	reset_from_highlight_to_default := "\033[0m"

	for day := 1; day <= last_of_month.Day(); day++ {

		if is_birthday(day, month) {

			fmt.Printf(
				"%s%2d%s ", 
				red_background_black_text_highlight_start, 
				day, 
				reset_from_highlight_to_default,
			)

		} else if is_holiday(day, month) {

			fmt.Printf(
				"%s%2d%s ", 
				cyan_background_black_text_highlight_start, 
				day, 
				reset_from_highlight_to_default,
			)

		} else if (day == today) {

			fmt.Printf(
				"%s%2d%s ", 
				white_background_black_text_highlight_start, 
				day, 
				reset_from_highlight_to_default,
			)

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
