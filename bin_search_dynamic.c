// b=binary; s=search; l=left; r=right; m=middle; a=array; t=target; re=result; c=compare;

#include <stdio.h>
#include <stdlib.h>

int c(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int b_s(int a[], int l, int r, int t) {
    while (l <= r) {
        int m = l + (r - l) / 2;
        printf("Current left index: %d\n", l);
        printf("Current right index: %d\n", r);
        printf("Current middle index: %d\n", m);
        if (a[m] == t) { 
            printf("The middle is the target: %d\n", m);
            printf("Current left index: %d\n", l);
            printf("Current right index: %d\n", r);
            printf("Current middle index: %d\n", m);
            return m; 
        }
        if (a[m] < t) { 
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
    int a[] = {423, 53, 3, 54, 23, 6, 4, 7, 32, 7, 2, 78, 2, 5454543, 432, 65012, 127899324};
    printf("The address of the array: %p\n", (void*)a);
    int n = sizeof(a)/sizeof(a[0]);
    printf("The amount of elements in the array: %d\n", n);
    qsort(a, n, sizeof(int), c);
    printf("The now sorted array: ");
    for (int i = 0; i < n; i++) {
        printf("\t%d\n", a[i]);
    }
    int t;
    printf("Enter your target: ");
    scanf("%d", &t);
    printf("The number I am searching for: %d\n", t);
    int re = b_s(a, 0, n - 1, t);
    if (re == -1) printf("Element is not present in the array.\n");
    else printf("Element is present and at index %d\n", re);
    return 0;
}
