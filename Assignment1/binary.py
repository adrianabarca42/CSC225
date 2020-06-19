# Implements operations on binary numbers.
# CSC 225, Assignment 1
# Given code, Winter '20
import math


def add(addend_a, addend_b):
    """
    Add two 8-bit, two's complement binary numbers; ignore carries/overflows.
    TODO: Implement this function. Do *not* convert the numbers to decimal.

    :param addend_a: A bitstring representing the first number
    :param addend_b: A bitstring representing the second number
    :return: A bitstring representing the sum
    """
    carry = False
    num = ""
    for i in range(7, -1, -1):
        sum1 = 0
        int1 = 0
        int2 = 0
        if addend_a[i] == "1":
            int1 = 1
        if addend_b[i] == "1":
            int2 = 1
        sum1 = int1 + int2
        if sum1 == 2:
            if carry == True:
                num = "1" + num
            else:
                num = "0" + num
            carry = True
        elif sum1 == 1:
            if carry == True:
                num = "0" + num
                carry = True
            else:
                num = "1" + num
                carry = False
        else:
            if carry == True:
                num = "1" + num
            else:
                num = "0" + num
            carry = False
    return num

def negate(number):
    """
    Negate an 8-bit, two's complement binary number.
    TODO: Implement this function. Do *not* convert the number to decimal.

    :param number: A bitstring representing the number to negate
    :return: A bistring representing the negated number
    """
    num = ""
    for i in range(7, -1, -1):
        if number[i] == "1":
            num = "0" + num
        else:
            num = "1" + num
    return add(num, "00000001") 
            


def subtract(minuend, subtrahend):
    """
    Subtract one 8-bit, two's complement binary number from another.
    TODO: Implement this function. Do *not* convert the numbers to decimal.

    :param minuend: A bitstring representing the number from which to subtract
    :param subtrahend: A bitstring representing the number to subtract
    :return: A bitstring representing the difference
    """
    return add(minuend, negate(subtrahend))


def binary_to_decimal(number):
    """
    Convert an 8-bit, two's complement binary number to decimal.
    TODO: Implement this function.

    :param number: A bitstring representing the number to convert
    :return: An integer, the converted number
    """
    sum = 0
    int = 0
    for i in range(7, -1, -1):
        if number[i] == "1":
            sum += (2**int) * 1
        int += 1
    return sum


def decimal_to_binary(number):
    """
    Convert a decimal number to 8-bit, two's complement binary.
    TODO: Implement this function.

    :param number: An integer, the number to convert
    :return: A bitstring representing the converted number
    :raise OverflowError: If the number cannot be represented with 8 bits
    """
    num = abs(number)
    bin_str = ""
    if number > 127 or number < -127:
        raise OverflowError
    while(num != 0):
        bin_str = "%d" % (num % 2) + bin_str
        num = math.floor(num/2)
    if len(bin_str) != 8:
        while(len(bin_str) < 8):
            bin_str = "0" + bin_str
    if number < 0:
        return negate(bin_str)
    return bin_str
    
