def num_to_words(number):
    units = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    teens = ["", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
    tens = ["", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    thousands = ["", "thousand", "million", "billion", "trillion", "quadrillion", "quintillion", "sextillion", "septillion", "octillion", "nonillion", "decillion", "undecillion", "duodecillion", "tredecillion", "quattuordecillion", "quindecillion", "sexdecillion", "septendecillion", "octodecillion", "novemdecillion", "vigintillion"]

    def wordify(n):
        if n < 10:
            return units[n]
        elif n == 10:
            return tens[n//10]
        elif 10 <= n < 20:
            return teens[n-10]
        elif 20 <= n < 100:
            return tens[n//10] + (" " + units[n%10] if (n%10 != 0) else "")
        elif 100 <= n < 1000:
            return units[n//100] + " hundred" + (" " + wordify(n%100) if (n%100 != 0) else "")
        else:
            for idx, value in enumerate(thousands):
                if n < 1000**(idx + 1):
                    return wordify(n // (1000**idx)) + " " + value + (" " + wordify(n % (1000**idx)) if (n % (1000**idx) != 0) else "")

    words = wordify(number).strip()
    return words[0].upper() + words[1:]

def x(n):
    n*=2**63
    return n

n = 1
result = x(n)
formatted_result = "{:,}".format(result)
result_in_words = num_to_words(result)

print(result)
print(formatted_result)
print(result_in_words)

