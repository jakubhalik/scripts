// b=binary; s=search; l=left; r=right; m=middle; a=array; t=target; re=result;

#include <stdio.h>

int b_s(int a[], int l, int r, int t) {
    int m = l + (r - l) / 2;
    if (a[m] == t) return m;
    if (a[m] < t) return l = m + 1;
    else r = m - 1;
    return -1;
}

int main() {
    int a[] = {423, 53, 3, 54, 23, 6, 4, 7, 32, 7, 2, 78, 2, 5454543, 432, 65012, 127899324};
    int n = sizeof(a)/sizeof(a[0]);
    int t = 54;
    int re = b_s(a, 0, n - 1, t);
    if (re == -1) printf("Element is not present in the array.");
    else printf("Element is present and index %d: ", re);
    return 0;
}
