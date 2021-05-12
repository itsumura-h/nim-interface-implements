import repository_interface
import ../../src/implements

type MockRepository = ref object

proc newMockRepository*():MockRepository =
  return MockRepository()

implements MockRepository, IReository:
  proc exec(self:MockRepository, msg:string):string =
    return "MockRepository " & msg
