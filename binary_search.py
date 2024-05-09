# b_s=binary_search; a=array; t=target; l=left; r=right; len=length; m=middle; i=index;
def b_s(a, t):
    l = 0
    r = len(a) - 1
    while l <= r:
        m = (l + r) // 2
        if a[m] == t:
            return mid
        elif a[m] < t:
            l = m + 1
        else:
            r = m - 1
    return -1

a = [12, 5432, 223, 64, 3, 54, 6, 12, 45, 6, 2, 5, 6, 12, 34787348, "dfs", 23, "fsdsdf", 324]
t = 223
i = b_s(a, t)
if i != -1: print("Target found at index: ", i, ".")
else: print("Target not found.")

