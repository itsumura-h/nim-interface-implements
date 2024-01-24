import std/strformat
import ./repository_interface

type MockRepository* = object of IRepository

proc new*(_:type MockRepository):MockRepository =
  return MockRepository()

method exec(self:MockRepository, msg:string):string =
  return &"MockRepository {msg}"
