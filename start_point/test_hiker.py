from hiker import global_answer, Hiker
import unittest

from approvaltests.approvals import verify
from approvaltests.reporters.generic_diff_reporter_factory \
    import GenericDiffReporterFactory


class HikerTest(unittest.TestCase):
    def setUp(self):
        self.reporter = GenericDiffReporterFactory().get_first_working()

    def test_global(self):
        result = str(global_answer())
        verify(result, self.reporter)

    def test_instance(self):
        result = str(Hiker().instance_answer())
        verify(result, self.reporter)


if __name__ == "__main__":
    unittest.main()
