import ./repository_interface

type Repository* = object of IRepository

proc execImpl(self:IRepository, msg:string):string =
  return "Repository " & msg

proc new*(_:type Repository):Repository =
  return Repository(
    exec:execImpl
  )
