package main

import (
	"fmt"
)

func quicksort(arr []int, low, high int) {
	if low < high {
		p := partition(arr, low, high)
		quicksort(arr, low, p-1)
		quicksort(arr, p+1, high)
	}
}

func partition(arr []int, low, high int) int {
	pivot := arr[high]
	i := low
	for j := low; j < high; j++ {
		if arr[j] < pivot {
			arr[i], arr[j] = arr[j], arr[i]
			i++
		}
	}
	arr[i], arr[high] = arr[high], arr[i]
	return i
}

func binarySearch(arr []int, target int) int {
	low := 0
	high := len(arr) - 1
	for low <= high {
		mid := (low + high) / 2
		if arr[mid] == target {
			return mid
		} else if arr[mid] < target {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return -1
}

func binSearch(arr []int, target int) int {
	quicksort(arr, 0, len(arr)-1)

    fmt.Printf("The sorted array: %v\n", arr)

	return binarySearch(arr, target)
}

func main() {
	arr := []int{34, 7, 23, 32, 5, 423, 12, 13, 431, 98543982, 231, 62}

    fmt.Printf("The original array: %v\n", arr);

	target := 23

    fmt.Printf("The target: %d\n", target);

	result := binSearch(arr, target)

	if result != -1 {
		fmt.Printf("Element found at index %d\n", result)
	} else {
		fmt.Println("Element not found")
	}
}
