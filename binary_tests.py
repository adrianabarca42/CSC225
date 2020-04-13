# Tests operations on binary numbers.
# CSC 225, Assignment 1
# Given tests, Winter '20

import unittest
import binary as bn


class TestBinary(unittest.TestCase):
    def test01_add(self):
        msg = "Testing basic binary addition"
        self.assertEqual(bn.add("00000011", "00000010"), "00000101", msg)
        self.assertEqual(bn.add("00111101", "00011100"), "01011001", msg)

    def test02_negate(self):
        msg = "Testing basic binary negation"
        self.assertEqual(bn.negate("00000001"), "11111111", msg)
        self.assertEqual(bn.negate("00110100"), "11001100", msg)

    def test03_subtract(self):
        msg = "Testing basic binary subtraction"
        self.assertEqual(bn.subtract("00000011", "00000010"), "00000001", msg)
        self.assertEqual(bn.subtract("11110110", "00000101"), "11110001", msg)
        self.assertEqual(bn.subtract("11111111", "11111101"), "00000010", msg)
        self.assertEqual(bn.subtract("00000101", "00000111"), "11111110", msg)

    def test04_binary_to_decimal(self):
        msg = "Testing basic binary-to-decimal conversion"
        self.assertEqual(bn.binary_to_decimal("00000101"), 5, msg)
        self.assertEqual(bn.binary_to_decimal("10101000"), 168, msg)

    def test05_decimal_to_binary(self):
        msg = "Testing basic decimal-to-binary conversion"
        self.assertEqual(bn.decimal_to_binary(5), "00000101", msg)
        self.assertEqual(bn.decimal_to_binary(-10), "11110110", msg)
        self.assertEqual(bn.decimal_to_binary(-37), "11011011", msg)
        with self.assertRaises(OverflowError): bn.decimal_to_binary(150)
        with self.assertRaises(OverflowError): bn.decimal_to_binary(-132)


if __name__ == "__main__":
    unittest.main()
