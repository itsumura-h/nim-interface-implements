import strformat
import ./repository_interface
import ../../src/interface_implements

type Repository* = ref object

proc new*(_:type Repository):Repository =
  return Repository()

implements Repository, IRepository:
  proc exec(self:Repository, msg:string):string =
    return &"Repository {msg}"
