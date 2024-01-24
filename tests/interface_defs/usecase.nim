import ./repository_interface

type Usecase* = object
  repo:IRepository

proc new*(_:type Usecase, repo:IRepository):Usecase =
  return Usecase(
    repo:repo
  )

proc exec*(self:Usecase, msg:string):string =
  return self.repo.exec(msg)
