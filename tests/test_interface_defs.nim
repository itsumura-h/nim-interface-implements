import ./interface_defs/usecase
import ./interface_defs/mock_repository
import ./interface_defs/repository

when NimMajor >= 2:
  block:
    let repository = MockRepository.new()
    let usecase = Usecase.new(repository)
    echo usecase.exec("mock")
    assert "MockRepository mock" == usecase.exec("mock")

  block:
    let repository = Repository.new()
    let usecase = Usecase.new(repository)
    echo usecase.exec("exec")
    assert "Repository exec" == usecase.exec("exec")
