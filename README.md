toInterface
===

![](https://github.com/itsumura-h/nim-to-interface/workflows/Build%20and%20test%20Nim/badge.svg)

`bindInterface` macro creates `toInterface` proc. It provides polymorphism.  
Multiple procedures can be set in `bindInterface` block.

```nim
bindInterface IReository, Repository:
  proc func1(self:Repository, msg:string):string =
    return "Repository1 " & msg

  proc func2(self:Repository, number:int):string =
    return "Repository2 " & $msg
```
This is converted to bellow

```nim
proc exec(self:Repository, msg:string):string =
  return "Repository " & msg

proc toInterface*(self:Repository):IReository =
  return (
    func1: proc(msg:string):string = self.func1(msg),
    func2: proc(number:int):string = self.func2(number)
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
