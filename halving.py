import math
# h=halving; s=sequence; n=number; l=length;
def h_s(n):
    if n < 1:
        print("NUmber must be greater than or equal to 1.")
        return

    n = math.ceil(n / 2)
    print(n)
    n1 = math.ceil(n / 2)
    print(n1)
    n2 = math.ceil(n + n1)
    print(n2)
    n3 = math.ceil(n1 / 2)
    print(n3)
    n4 = math.ceil(n2 + n3)
    print(n4)
    n5 = math.ceil(n2 / 2)
    print(n5)
    n6 = math.ceil(n1 + n5)
    print(n6)
    n7 = math.ceil(n3 + n5)
    print(n7)
    n8 = math.ceil(n1 + n7)
    print(n8)
    n9 = math.ceil(n3 / 2)
    print(n9)

n = float(input("Enter a number: "))
h_s(n)

