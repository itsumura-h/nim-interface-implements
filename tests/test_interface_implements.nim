import ./interface_implements/usecase
import ./interface_implements/mock_repository
import ./interface_implements/repository


block:
  let repository = MockRepository.new()
  let usecase = Usecase.new(repository)
  assert "MockRepository mock" == usecase.exec("mock")

block:
  let repository = Repository.new()
  let usecase = Usecase.new(repository)
  assert "Repository exec" == usecase.exec("exec")
