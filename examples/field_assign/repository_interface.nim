type IRepository* = object of RootObj
  exec:proc(self:IRepository, msg:string):string

proc exec*(self:IRepository, msg:string):string = self.exec(self, msg)
