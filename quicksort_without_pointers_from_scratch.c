void swap(int array[], int i, int j) {
    int temp = array[i];

    array[i] = array[j];

    array[j] = temp;
}

int partition(int array[], int low, int high) {
    int pivot = array[high];

    int i = low - 1;

    for (int j = low; j < high; j++) {
        if (array[j] < pivot) {
            i++;

            swap(array, i, j);
        }

    }

    swap(array, i + 1, high);

    return i + 1;
}

void quicksort(int array[], int low, int high) {
    if (low < high) {
        int pivotIndex = partition(array, low, high);

        quicksort(array, low, pivotIndex - 1);

        quicksort(array, pivotIndex + 1, high);
    }
}

void intToStr(int value, char str[]) {
    int i = 0;

    int isNegative = 0;

    if (value == 0) {
        str[i++] = '0';

        str[i] = '\0';

        return;
    }

    if (value < 0) {
        isNegative = 1;

        value = -value;
    }

    while (value != 0) {
        int remainder = value % 10;

        str[i++] = remainder + '0';

        value = value / 10;
    }

    if (isNegative) {
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
            // Clobbered registers: RCX Sand R11 are used by syscall,
            // clobbered, modified, by the syscall instruction,
                // so they need to be saved if their values are needed
                    // after the call.
            // RCX is a count register.
            // R11 is the eleventh general-purpose register in 64-bit mode.
            // memory: This indicates to the compiler that the assembly code 
                // may read or write memory, 
                    // preventing certain optimizations around this code.
    );
}

void output(const char str[]) {
    int length = 0;

    while (str[length] != '\0') {
        length++;
    }

    system_write(1, str, length);
}

void output_char(char character) {
    char str[2];

    str[0] = character;

    str[1] = '\0';

    output(str);
}

int main() {
    int array[] = {21, 4, 6, 3, 342, 9, 22, 432};

    output('The original array: ', array);

    int amount_of_numbers = 8;

    output('The amount of numbers in the array: ', amount_of_numbers);

    quicksort(array, 0, amount_of_numbers - 1);

    for (int i = 0; i < amount_of_numbers; i++) {

        char buffer[12];

        intToStr(array[i], buffer);

        output(buffer);

        if (i < amount_of_numbers - 1) {
            output_char(',');

            output_char(' ');
        }
    }

    output_char('\n');

    return 0;
}

