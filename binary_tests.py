# Tests operations on binary numbers.
# CSC 225, Assignment 1
# Given tests, Winter '20

import unittest
import binary as bn


class TestBinary(unittest.TestCase):
    def test01_add(self):
        msg = "Testing basic binary addition"
        self.assertEqual(bn.add("00000011", "00000010"), "00000101", msg)

    def test02_negate(self):
        msg = "Testing basic binary negation"
        self.assertEqual(bn.negate("00000001"), "11111111", msg)

    def test03_subtract(self):
        msg = "Testing basic binary subtraction"
        self.assertEqual(bn.subtract("00000011", "00000010"), "00000001", msg)

    def test04_binary_to_decimal(self):
        msg = "Testing basic binary-to-decimal conversion"
        self.assertEqual(bn.binary_to_decimal("00000101"), 5, msg)

    def test05_decimal_to_binary(self):
        msg = "Testing basic decimal-to-binary conversion"
        self.assertEqual(bn.decimal_to_binary(5), "00000101", msg)


if __name__ == "__main__":
    unittest.main()
