import repository_interface
import ../../src/to_interface

type Repository = ref object

proc newRepository*():Repository =
  return Repository()

bindInterface IReository, Repository:
  proc exec(self:Repository, msg:string):string =
    return "Repository " & msg
