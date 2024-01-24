import ./repository
import ./usecase

proc main() =
  let repo = Repository.new()
  let usecase = Usecase.new(repo)
  usecase.exec()

main()
