import ddd/usecase
import ddd/mock_repository
import ddd/repository


block:
  let repository = MockRepository.new(1).toInterface()
  let usecase = Usecase.new(repository)
  assert "MockRepository 1 mock" == usecase.exec("mock")

block:
  let repository = Repository.new("a").toInterface()
  let usecase = Usecase.new(repository)
  assert "Repository a exec" == usecase.exec("exec")
