# b_s=binary_search; a=array; t=target; l=left; r=right; len=length; m=middle; i=index;
def b_s(a, t):
    a = sorted(map(str, a))
    l = 0
    r = len(a) - 1
    while l <= r:
        m = (l + r) // 2
        print("Current left index:", l)
        print("Current right index:", r)
        print("Current middle index:", m)
        if str(a[m]) == str(t):
            return m
        elif str(a[m]) < str(t):
            l = m + 1
        else:
            r = m - 1
    return -1

a = [12, 5432, 223, 64, 3, 54, 6, 12, 45, 6, 2, 5, 6, 12, 34787348, "dfs", 23, "fsdsdf", 324]
print("The array:", a)
t = 223
print("The target:", t)
i = b_s(a, t)
if i != -1: print("TARGET FOUND AT INDEX:", i)
else: print("TARGET NOT FOUND.")

