import ../src/implements
import ddd/usecase
import ddd/mock_repository
import ddd/repository


block:
  let repository = newMockRepository().toInterface()
  let usecase = newUsecase(repository)
  assert "MockRepository mock" == usecase.exec("mock")

block:
  let repository = newRepository().toInterface()
  let usecase = newUsecase(repository)
  assert "Repository exec" == usecase.exec("exec")
