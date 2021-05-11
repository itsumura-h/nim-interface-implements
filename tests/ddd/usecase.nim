import repository_interface

type Usecase = ref object
  repository: IReository

func newUsecase*(repository:IReository):Usecase =
  return Usecase(repository:repository)

proc exec*(self:Usecase, msg:string):string =
  return self.repository.exec(msg)
