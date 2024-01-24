import strformat
import repository_interface
import ../../src/interface_implements

type MockRepository* = ref object

proc new*(_:type MockRepository):MockRepository =
  return MockRepository()

implements MockRepository, IRepository:
  proc exec(self:MockRepository, msg:string):string =
    return &"MockRepository {msg}"
