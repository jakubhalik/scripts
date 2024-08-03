#define white_background_black_text_highlight_start "\033[47m\033[30m"
#define cyan_background_black_text_highlight_start "\033[46m\033[30m"
#define red_background_black_text_highlight_start "\033[41m\033[30m"

#define reset_from_highlight_to_default "\033[0m"

struct time_specification {
    long time_value_second;
    long time_value_nanosecond;
};

int system_get_time(int number, unsigned long clock_id, struct time_specification *timespec) {
    unsigned long result;

    asm volatile (
        "syscall"

        // The equal sign before a indicates that 
            // file_descriptor_and_output_operand is an output operand. 
        // This means that the value of arg1 is produced by the assembly code 
        // and will be written to it after the assembly code executes.
        // The letter a refers to the RAX register in x86-64 architecture. 
        // The RAX register is commonly used for return values in system calls 
        // and function calls. 
        // RAX is an accumulator register.
        // By specifying a, you're telling the compiler that this operand 
            // should be associated with the RAX register.
        : "=a" (result)

        : 
            "a" (number), 
            "D" (clock_id),
            "S" (timespec)

        : "rcx", "r11", "memory"

    );

    if (result < 0) {
        return -1;
    }

    return 0;

}

#define clock_realtime 0

// 228 is a system call number for clock_gettime on x86-64 Linux
#define sys_clock_get_time 228

int calculate_day_of_week(int day_of_month, int month, int year) {

    if (month < 3) {
        month += 12;
        year -= 1;
    }

    int year_of_century = year % 100;

    int zero_based_century = year / 100;

    int day_of_week = (
        day_of_month + 
        (13 * (month + 1)) / 5 +
        year_of_century + 
        year_of_century / 4 +
        zero_based_century / 4 -
        2 * zero_based_century
    ) % 7;

    return (day_of_week + 5) % 7;

}

int is_leap_year(int year) {
    if (year % 4 == 0) {

        if (year % 100 == 0) {

            return year % 400 == 0;

        }

        return 1;
    }

    return 0;
}

int days_in_month(int month, int year) {

    if (month == 2) {
        return is_leap_year(year) ? 29 : 28;
    }

    if (month == 4 || month == 6 || month == 9 || month == 11) {
        return 30;
    }

    return 31;
}

void int_to_str(int value, char str[]) {
    int i = 0;

    int is_negative = 0;

    if (value == 0) {
        str[i++] = '0';

        str[i] = '\0';

        return;
    }

    if (value < 0) {
        is_negative = 1;

        value = -value;

    } else {
        is_negative = 0;
    }

    while (value != 0) {
        int remainder = value % 10;

        str[i++] = remainder + '0';

        value = value / 10;
    }

    if (is_negative) {
        str[i++] = '-';
    }

    str[i] = '\0';

    for (int start = 0, end = i - 1; start < end; start++, end--) {
        char temp = str[start];

        str[start] = str[end];

        str[end] = temp;
    }
}

void system_write(int file_descriptor, const char buffer[], int count) {
    // `volatile` tells the compiler to not optimize this assembly code away 
        // or reorder it because it has side effects 
            // that the compiler may not understand
    asm volatile (
        // syscall is an asm instruction that triggers a system call in
            // x86-64 architecture.
        // The syscall instruction is used to request a service from the kernel
        "syscall"

        // No output operands
        :

        // Doing inputs from here down
        : 
            // Using syscall n 1 for writing into RAX
            // RAX is an accumulator register, 
                // used for storing return values 
                    // from functions and system calls
            "a"(1),

            // File descriptor into RDI
            // RDI is a destination index register, 
                // used for string and memory operations
            "D"(file_descriptor),

            // Address of buffer into RSI
            // RSI is a source index register,
                // used for string operations and as a general-purpose register
            // In C, when you pass an array to a function, 
                // it decays to a pointer to the first element. 
            // So, using buf in the context of function parameters 
                // is equivalent to &buf[0]. 
            // However, when dealing with inline assembly, 
                // being explicit with &buf[0] ensures clarity 
                    // about the intent to get the address of the first element
            "S"(&buffer[0]),

            // Number of bytes to write into the RDX.
            // RDX is a data register. Used to hold data for operations.
            "d"(count)

            // Clobbered registers: RCX and R11 are used by syscall,
            // clobbered, modified, by the syscall instruction,
                // so they need to be saved if their values are needed
                    // after the call.
            // RCX is a count register.
            // R11 is the eleventh general-purpose register in 64-bit mode.
            // memory: This indicates to the compiler that the assembly code 
                // may read or write memory, 
                    // preventing certain optimizations around this code.

            : "rcx", "r11", "memory"
    );
}

void output(const char str[]) {
    int length = 0;

    while (str[length] != '\0') {
        length++;
    }

    system_write(1, str, length);
}

// :%s/,/\r/g

void output_cal(int year, int month, int today) {

    const char months[12][10] = {
        "January",
         "February",
         "March",
         "April",
         "May",
         "June",
         "July",
         "August",
         "September",
         "October",
         "November",
         "December"
    };

    const char days_of_week[7][3] = {"Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"};

    char month_and_year[20];

    char day_str[3];

    output("    ");
    output(months[month - 1]);
    output(" ");

    int_to_str(year, month_and_year);
    output(month_and_year);
    output("\n");

    for (int i = 0; i < 7; i++) {
        output(days_of_week[i]);
        output(" ");
    }
    output("\n");

    int start_day = calculate_day_of_week(1, month, year);

    int days_in_this_month = days_in_month(month, year);

    int current_day = 1;

    for (int i = 0; i < start_day; i++) {
        output("   ");
    }

    for (current_day = 1; current_day <= days_in_this_month; current_day++) {

        if (current_day == today) {
            output(white_background_black_text_highlight_start);
        }

        int_to_str(current_day, day_str);

        if (current_day < 10) {
            output(" ");
        }

        output(day_str);
        
        if (current_day == today) {
            output(reset_from_highlight_to_default);
        }

        output(" ");
        
        if ((start_day + current_day) % 7 == 0) {
            output("\n");
        }

    }

    if ((start_day + days_in_this_month) % 7 != 0) {
        output("\n");
    }

}

int main() {
    struct time_specification timespec;

    if (system_get_time(sys_clock_get_time, clock_realtime, &timespec) == 0) {

        long seconds = timespec.time_value_second;

        // Calculate current date and time from seconds since the epoch
        int year = 1970, month = 0, day = 0;
        int days_per_month[2][12] = {
            {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
            {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        };

        int leap;

        while (1) {

            leap = is_leap_year(year);

            int days_in_year = leap ? 366 : 365;

            if (seconds < days_in_year * 86400) break;

            seconds -= days_in_year * 86400;

            year++;

        }

        for (month = 0; month < 12; month++) {

            if (seconds < days_per_month[leap][month] * 86400) break;

            seconds -= days_per_month[leap][month] * 86400;

        }

        month++;

        day = seconds / 86400 + 1;

        output_cal(year, month, day);

    } else {
        output("Failed to get time\n");
    }

    return 0;
}

