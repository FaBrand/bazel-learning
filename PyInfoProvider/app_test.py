import sys
import unittest


class TestStringMethods(unittest.TestCase):

    def test_import_generated(self):
        import MyLib
        self.assertEqual(MyLib.CONSTANT_IN_LIB, 42)

    def test_import_sub_generated_module_absolute(self):
        from a.sub.package.SubLib import CONSTANT_IN_LIB
        self.assertEqual(CONSTANT_IN_LIB, 43)

    def test_import_sub_generated_module_relative(self):
        import SubLib
        self.assertEqual(SubLib.CONSTANT_IN_LIB, 43)

    def test_import_example_sub_module_absolute(self):
        from a.sub.package.example_module import CONSTANT_IN_LIB
        self.assertEqual(CONSTANT_IN_LIB, 84)

    def test_import_example_sub_module_relative(self):
        import example_module
        self.assertEqual(example_module.CONSTANT_IN_LIB, 84)


if __name__ == "__main__":
    __import__('pprint').pprint(sys.path)
    unittest.main()
