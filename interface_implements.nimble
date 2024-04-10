# Package

version       = "0.2.5"
author        = "dumblepy"
description   = "Creating toInterface macro."
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.2.0"


import std/strformat
import std/os

task test, "run testament test":
  exec &"testament p 'tests/test_*.nim'"
  for kind, path in walkDir(getCurrentDir() / "tests"):
    if not path.contains(".") and path.fileExists():
      exec "rm -f " & path
