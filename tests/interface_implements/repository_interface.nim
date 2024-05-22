type IRepository* = object
  exec*: proc(msg:string):string
