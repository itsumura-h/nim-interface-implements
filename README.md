toInterface
===

`bindInterface` macro creates `toInterface` proc. It provides polymorphism.

```nim
bindInterface IReository, Repository:
  proc exec(self:Repository, msg:string):string =
    return "Repository " & msg
```
This is converted to bellow

```nim
proc exec(self:Repository, msg:string):string =
  return "Repository " & msg

proc toInterface*(self:Repository):IReository =
  return (
    exec: proc(msg:string):string = self.exec(msg)
  )
```

## API
```nim
macro bindInterface*(interfaceName, implName, procs:untyped):untyped
```

## Example

repository_interface.nim
```nim
type IReository* = tuple
  exec: proc(msg:string):string
```

mock_repository.nim
```nim
import repository_interface
import to_interface

type MockRepository = ref object

proc newMockRepository*():MockRepository =
  return MockRepository()

bindInterface IReository, MockRepository:
  proc exec(self:MockRepository, msg:string):string =
    return "MockRepository " & msg
```

repository.nim
```nim
import repository_interface
import to_interface

type Repository = ref object

proc newRepository*():Repository =
  return Repository()

bindInterface IReository, Repository:
  proc exec(self:Repository, msg:string):string =
    return "Repository " & msg
```

usecase.nim
```nim
import repository_interface

type Usecase = ref object
  repository: IReository

func newUsecase*(repository:IReository):Usecase =
  return Usecase(repository:repository)

proc exec*(self:Usecase, msg:string):string =
  return self.repository.exec(msg)
```

presentation layer
```nim
block:
  let repository = newMockRepository().toInterface()
  let usecase = newUsecase(repository)
  assert "MockRepository mock" == usecase.exec("mock")

block:
  let repository = newRepository().toInterface()
  let usecase = newUsecase(repository)
  assert "Repository exec" == usecase.exec("exec")
```
