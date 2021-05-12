import repository_interface
import ../../src/interface_implements

type Repository = ref object

proc newRepository*():Repository =
  return Repository()

implements Repository, IReository:
  proc exec(self:Repository, msg:string):string =
    return "Repository " & msg
