# h=halving; s=sequence; n=number; p=power;
def h_s(n):
    if n < 1:
        print("NUmber must be greater than or equal to 1.")
        return
    p=0
    while 2 ** p <= n:
        p += 1
    for i in range(p, -1, -1):
        print(2 ** i)

n = int(input("Enter a number: "))
h_s(n)
