import repository_interface
import ../../src/to_interface

type MockRepository = ref object

proc newMockRepository*():MockRepository =
  return MockRepository()

bindInterface IReository, MockRepository:
  proc exec(self:MockRepository, msg:string):string =
    return "MockRepository " & msg
