package main

import (
	"bufio"
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	linesGo := map[string]bool{
		"4 Hours of Asian Mum to Help You Focus on Practising⧸Studying⧸Working [3RGEo2Kohb8].webm":                                  true,
		"A Highwayman Inspired Playlist (Over The Garden Wall - Evil Jazz, Dark Cabaret, Macabre) [oGrov9YifJg].webm":              true,
		"A new browser I'm actually hyped about [tKM2N4TQHQY].webm":                                                                true,
		"Arch Linux Installation Guide 2024： An Easy to Follow Tutorial [FxeriGuJKTM].webm":                                       true,
		"Best Linux Rice of 2022 - r⧸unixporn [5Lt7nkMP1Ms].webm":                                                                  true,
		"DIY IOT FULLY AUTOMATIC WASHING MACHINE ｜ Raspberry pi ｜ Arduino ｜ ESP32 ｜ DIY Washing Machine [Vg9p9qNS1PY].mkv":      true,
		"DIY IOT WASHING MACHINE Circuit Diagram｜ Raspberry pi ｜ Arduino ｜ ESP32 ｜ DIY Washing Machine [O9JsWFQWLb8].mkv":       true,
		"Do Smart Drugs Actually Work？ [LQI-kIrmuAM].webm":                                                                        true,
		"H.E. Washing Machines Are Jerks! [qkK2RQILV2s].mkv":                                                                      true,
		"Linux Ricing Crash Course (minimal, simple yet pretty rice for newbies) [SRqVuAUP2N0].webm":                              true,
		"Microservices [y8OnoxKotPQ].webm":                                                                                        true,
		"PYTHON CODE OF DIY IOT AUTOMATIC WASHING MACHINE ｜ Raspberry pi ｜ Arduino ｜ ESP32｜ DIY Was Machine [ubfWcjc0D9s].mkv":  true,
		"SCRUM： An Honest Ad [fTaOdbUbFmI].webm":                                                                                 true,
		"Screen Tearing Test [MfL_JkcEFbE].webm":                                                                                  true,
		"The First Site to Visit After Installing Firefox [lmA8Ex-G5IQ].webm":                                                     true,
		"Why don’t more people build Kitchens like this？ [OoyNkAVo-OE].webm":                                                      true,
		"lotrando_a_zubejda.mp4":                                                                                                  true,
		"nedotknutelni.mkv":                                                                                                       true,
		"nvim_nextjs.webm":                                                                                                        true,
		"nvim_nextjs_setup.webm":                                                                                                  true,
		"over_the_garden_wall":                                                                                                    true,
		"w":                                                                                                                       true,
		"when your serverless computing bill goes parabolic... [SCIfWhAheVw].webm":                                                true,
		"where should you live in Europe？ [oMmD_UYrLgk].webm":                                                                     true,
	}

	linesSh, err := runCommand("ls", "/home/x/v")
	if err != nil {
		fmt.Printf("Error running ls /home/x/v: %v\n", err)
		return
	}

	compareLines(linesGo, linesSh, "Predefined File List", "ls /home/x/v")
}

func runCommand(name string, arg ...string) (map[string]bool, error) {
	cmd := exec.Command(name, arg...)
	output, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	lines := make(map[string]bool)
	scanner := bufio.NewScanner(strings.NewReader(string(output)))
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line != "" {
			lines[line] = true
		}
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return lines, nil
}

func compareLines(lines1, lines2 map[string]bool, source1, source2 string) {
	fmt.Printf("Lines unique to %s:\n", source1)
	for line := range lines1 {
		if !lines2[line] {
			fmt.Println(line)
		}
	}

	fmt.Printf("\nLines unique to %s:\n", source2)
	for line := range lines2 {
		if !lines1[line] {
			fmt.Println(line)
		}
	}
}

