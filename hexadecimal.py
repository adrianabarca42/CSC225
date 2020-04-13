# Implements operations on hexadecimal numbers.
# CSC 225, Assignment 1
# Given code, Winter '20
import binary

def binary_to_hex(number):
    """
    Convert a 16-bit binary number to hexadecimal.
    TODO: Implement this function.

    :param number: A bitstring representing the number to convert
    :return: A hexadecimal string, the converted number
    """
    hex_str = ""
    str_pieces = [number[i:i+4] for i in range(0, len(number), 4)]
    for i in range(len(str_pieces)):
        if str_pieces[i] == "1010":
            hex_str = "A" + hex_str
        elif str_pieces[i] == 1011:
            hex_str = "B" + hex_str
        elif str_pieces[i] == 1100:
            hex_str = "C" + hex_str
        elif str_pieces[i] == 1101:
            hex_str = "D" + hex_str
        elif str_pieces[i] == 1110:
            hex_str = "E" + hex_str
        elif str_pieces[i] == 1111:
            hex_str = "E" + hex_str
        else:
            num = binary.binary_to_decimal("0000" + str_pieces[i])
            num_str = "%d" % (num)
            hex_str = num_str + hex_str
    return "0x" + hex_str[::-1]

def hex_to_binary(number):
    """
    Convert a hexadecimal number to 16-bit binary.
    TODO: Implement this function.

    :param number: A hexadecimal string, the number to convert
    :return: A bitstring representing the converted number
    """
    bin_str = ""
    num = "0"
    d = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}
    concat_str = number[2:]
    for str_piece in concat_str:
        if str_piece == "A":
            bin_str = bin_str + "1010"
        elif str_piece == "B":
            bin_str = bin_str + "1011"
        elif str_piece == "C":
            bin_str = bin_str + "1100"
        elif str_piece == "D":
            bin_str = bin_str + "1101"
        elif str_piece == "E":
            bin_str = bin_str + "1110"
        elif str_piece == "F":
            bin_str = bin_str + "1111"
        else:
           num = d[str_piece]
           bin_str = bin_str + binary.decimal_to_binary(num)[4:]
    return bin_str 
