import ../../src/interface_implements

interfaceDefs:
  type IRepository* = object of RootObj
    exec: proc(self:IRepository, msg:string):string

  type IRepository2* = object of RootObj
    hoge: proc(self:IRepository)

# type IRepository* = object of RootObj
# method exec*(self:IRepository, msg:string):string {.base.} = {.warning:"Implementation exec is not found".}
