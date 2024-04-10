import macros, strutils, strformat

macro implements*(implName, interfaceName, procs:untyped):untyped =
  let procsStr = procs.repr
  var tuples = ""
  for i, aProc in procs:
    if aProc.repr == "discard":
      break
    var args: seq[string]
    var anonimousProcArgs: seq[string]
    let procName = aProc[0]
    let procImpl = aProc[3]
    if procName.repr.contains("*"):
      raise newException(Exception, "procedure in interface must be private.")
    let returnType = if procImpl[0].repr.len > 0: ":" & procImpl[0].repr else: ""
    for arg in procImpl[2..^1]:
      let argName = arg[0].repr
      let argType = arg[1].repr
      args.add(argName)
      anonimousProcArgs.add(&"{argName}: {argType}")
    let argPart = args.join(", ")
    let anonimousProcArgsStr = anonimousProcArgs.join(", ")
    var tupleRow = fmt"    {procName.repr}: proc({anonimousProcArgsStr}){returnType} = self.{procName.repr}({argPart})"
    if i != 0: tuples.add(",\n")
    tuples.add(tupleRow)
  let resultStr =
    if tuples.len == 0:
     fmt"""converter toInterface*(self:{implName.repr}):{interfaceName.repr} =
  return ()
"""
    else:
      fmt"""converter toInterface*(self:{implName.repr}):{interfaceName.repr} =
  return (
{tuples}
  )
"""
  return (procsStr & '\n' & resultStr).parseStmt

# ================================================================================

# interfaceDefs:
#   type IRepository* = object of RootObj
#     hoge: proc (self: IRepository, str:string):Future[string]
#   type IRepository2* = object of RootObj
#     hoge: proc (self: IRepository2, str:string):Future[string]

when NimMajor >= 2:
  macro interfaceDefs*(body:untyped):untyped =
    var res = ""
    for i, interfaceRows in body: # type IRepository* = object of RootObj | type IRepository2* = object of RootObj
      let interfaceName = interfaceRows[0][0].repr.replace("*", "")
      let interfaceDef = interfaceRows[0].repr.splitLines()[0] # IRepository* = object of RootObj
      var methods:seq[string]
      let procRows = interfaceRows[0][2][2]
      for procRow in procRows: # hoge: proc (self: IRepository, str:string):Future[string]
        let procName = procRow[0].repr.replace("*", "") # hoge
        let procDef = procRow[1][0] # (self: IRepository, str:string):Future[string]
        var returnType = ""
        var args:seq[string] # @["self: IRepository", "str: string"]
        var argNames:seq[string] # @["self", "str"]
        for i, argsRow in procDef:
          if i == 0:
            if argsRow.repr.len > 0: returnType = ":" & argsRow.repr # :Future[string]
            continue
          let argDef = argsRow.repr # self: IRepository | str: string
          args.add(argDef)
          let argName = argsRow[0].repr # self | str
          argNames.add(argName)

        let argsInMethod = args.join(", ")
        let methodRow = fmt(
          "method [procName]*([argsInMethod])[returnType] {.base.} = raise newException(CatchableError, \"Implementation [procName] of [interfaceName] is not found\")",
          '[',
          ']',
        )
        methods.add(methodRow)
      let interfaceStr = if i == 0: &"type {interfaceDef}\n" else: &"\ntype {interfaceDef}\n"
      res.add(interfaceStr & methods.join("\n") & "\n" )
    when not defined(release): echo res
    return parseStmt(res)
