import ./repository_interface

type Usecase* = object
  repo:IRepository

proc new*(_:type Usecase, repo:IRepository):Usecase =
  return Usecase(
    repo:repo
  )

proc exec*(self:Usecase) =
  echo self.repo.exec("hoge")
