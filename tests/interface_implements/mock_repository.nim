import std/strformat
import ./repository_interface
import ../../src/interface_implements

type MockRepository* = object

proc new*(_:type MockRepository):MockRepository =
  return MockRepository()

implements MockRepository, IRepository:
  proc exec(self:MockRepository, msg:string):string =
    return &"MockRepository {msg}"
