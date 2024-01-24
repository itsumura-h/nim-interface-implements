type IRepository* = object of RootObj

method exec*(self:IRepository, msg:string):string {.base.} = raise newException(Exception, "")
