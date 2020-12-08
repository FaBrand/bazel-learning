import os
import sys
from pathlib import Path


from rules_python.python.runfiles import runfiles

if __name__ == "__main__":
    r = runfiles.Create()
    for arg in sys.argv[2:]:
        print("arg", arg)
        print("argv1", sys.argv[1])
        print("Rlocation", r.Rlocation(sys.argv[1]+'/'+arg))
        p_arg = Path(r.Rlocation(sys.argv[1]+'/'+arg))
        print(p_arg, p_arg.exists())
