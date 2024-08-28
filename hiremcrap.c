#include <stdio.h>
#include <string.h>

void remove_pattern(char *line) {
    char *start;
    while ((start = strstr(line, ":0;")) != NULL) {
        char *end = start + 3; // Move past ":0;"
        while (start > line && *(start - 1) >= '0' && *(start - 1) <= '9') start--; // Move back to include the number
        if (start > line && *(start - 1) == ':') start--; // Include the preceding colon
        memmove(start, end, strlen(end) + 1); // Shift the rest of the line left
    }
    // Remove any leading colons or spaces if they exist
    if (*line == ':') memmove(line, line + 1, strlen(line));
    if (*line == ' ') memmove(line, line + 1, strlen(line));
}

int main() {
    char line[1024];
    while (fgets(line, sizeof(line), stdin)) {
        remove_pattern(line);
        printf("%s", line);
    }
    return 0;
}
