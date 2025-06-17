import sys, getopt
import TestPython

import sys
# import button
# from PyQt5.QtWidgets import QApplication, QMainWindow

def main(argv):
    opts, args = getopt.getopt(argv,"hi:s:o:",["excel=","sheet=","ofile="])
    for opt, arg in opts:
        if opt == '-h':
            sys.exit()
        if opt in ("-i", "--excel"):
            inputfile = arg
        if opt in ("-k", "--sheet"):
            inputsheet = arg
if __name__ == "__main__":
    main(sys.argv[1:])