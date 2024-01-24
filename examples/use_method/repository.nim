import ./repository_interface

type Repository* = object of IRepository

proc new*(_:type Repository):Repository =
  return Repository()

method exec*(self:Repository, msg:string):string =
  return "Repository " & msg
