
import math

def fibonacci_indices(limit):
    a, b = 0, 1
    indices = set()
    while b <= limit:
        indices.add(b)
        a, b = b, a + b
    return indices

def should_use_fib_rule(index, fib_indices):
    return index in fib_indices

def generate_sequence(n):
    seq = []
    processed_half = set()
    fib_indices = fibonacci_indices(2 * n)  # Get Fibonacci indices to influence operation
    current = math.ceil(n / 2)
    seq.append(current)

    while len(seq) < n:
        if len(seq) == 1 or current not in processed_half:
            current = math.ceil(current / 2)
            processed_half.add(current)
        else:
            if len(seq) > 1:
                sum_last_two = seq[-1] + seq[-2]
                if sum_last_two < n and sum_last_two not in seq:
                    current = sum_last_two
                elif should_use_fib_rule(len(seq), fib_indices):
                    current = math.ceil(sum_last_two / 2)
                else:
                    current = sum_last_two
            else:
                current = math.ceil(current / 2)

        if current > n or current in seq:
            current = min(set(range(1, n + 1)) - set(seq), default=1)  # Safe fallback

        seq.append(current)
        if len(seq) == n:
            break

    return seq

# Example
n = 10
sequence = generate_sequence(n)
print(sequence)

