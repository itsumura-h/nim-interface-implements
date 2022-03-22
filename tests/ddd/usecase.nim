import repository_interface

type Usecase* = ref object
  repository: IRepository

func new*(_:type Usecase, repository:IRepository):Usecase =
  return Usecase(repository:repository)

proc exec*(self:Usecase, msg:string):string =
  return self.repository.exec(msg)
