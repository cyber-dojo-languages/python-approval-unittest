import hiker
import unittest

from approvaltests.approvals import verify
from approvaltests.reporters.generic_diff_reporter_factory import GenericDiffReporterFactory


class GettingStartedTest(unittest.TestCase):
    def setUp(self):
        self.reporter = GenericDiffReporterFactory().get_first_working()

    def test_life_the_universe_and_everything(self):
       '''a simple example to start you off'''
       douglas = hiker.Hiker()
       result = str(douglas.answer())
       verify(result, self.reporter)       


if __name__ == "__main__":
    unittest.main()
