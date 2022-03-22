import strformat
import repository_interface
import ../../src/interface_implements

type Repository* = ref object
  key:string

proc new*(_:type Repository, key:string):Repository =
  return Repository(
    key:key
  )

implements Repository, IRepository:
  proc exec(self:Repository, msg:string):string =
    return &"Repository {self.key} {msg}"
