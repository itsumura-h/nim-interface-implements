import strformat
import repository_interface
import ../../src/interface_implements

type MockRepository* = ref object
  num:int

proc new*(_:type MockRepository, num:int):MockRepository =
  return MockRepository(
    num:num
  )

implements MockRepository, IRepository:
  proc exec(self:MockRepository, msg:string):string =
    return &"MockRepository {self.num} {msg}"
