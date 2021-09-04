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
     fmt"""proc toInterface*(self:{implName.repr}):{interfaceName.repr} =
  return ()
"""
    else:
      fmt"""proc toInterface*(self:{implName.repr}):{interfaceName.repr} =
  return (
{tuples}
  )
"""
  return (procsStr & '\n' & resultStr).parseStmt
