// b=binary; s=search; l=left; r=right; m=middle; a=array; t=target; re=result; c=compare;

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int c(const void *a, const void *b) {
    const char **ia = (const char **)a;
    const char **ib = (const char **)b;
    return strcmp(*ia, *ib);
}

int b_s(char *a[], int l, int r, char *t) {
    while (l <= r) {
        int m = l + (r - l) / 2;
        int res = strcmp(a[m], t);
        printf("Current left index: %d\n", l);
        printf("Current right index: %d\n", r);
        printf("Current middle index: %d\n", m);
        if (res == 0) { 
            printf("The middle is the target: %d\n", m);
            printf("Current left index: %d\n", l);
            printf("Current right index: %d\n", r);
            printf("Current middle index: %d\n", m);
            return m; 
        }
        if (res < 0) { 
            printf("Middle is smaller than the target.\n");
            l = m + 1; 
            printf("Incremented left for it to equal middle + 1.\n");
            printf("Current left index: %d\n", l);
            printf("Current right index: %d\n", r);
            printf("Current middle index: %d\n", m);
        }
        else  { 
            r = m - 1; 
            printf("Decremented right to equal middle - 1.\n");
            printf("Current left index: %d\n", l);
            printf("Current right index: %d\n", r);
            printf("Current middle index: %d\n", m);
        }
    }
    return -1;
}

int main() {
    char *a[] = {"so", "tell", "me", "why", "aint", "nothing", "but", "a", "heartbreak", "so", "tell", "me", "why"};
    printf("The address of the array: %p\n", (void*)a);
    int n = sizeof(a)/sizeof(a[0]);
    printf("The amount of elements in the array: %d\n", n);
    qsort(a, n, sizeof(char *), c);
    printf("The now sorted array: ");
    for (int i = 0; i < n; i++) {
        printf("\t%s\n", a[i]);
    }
    char t[100];
    printf("Enter your target: ");
    scanf("%99s", t);
    printf("The string I am searching for: %d\n", t);
    int re = b_s(a, 0, n - 1, t);
    if (re == -1) printf("Element is not present in the array.\n");
    else printf("Element is present and at index %d\n", re);
    return 0;
}
