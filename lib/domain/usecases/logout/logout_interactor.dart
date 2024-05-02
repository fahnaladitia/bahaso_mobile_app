import 'package:bahaso_mobile_app/domain/repositories/repositories.dart';

import 'logout_usecase.dart';

class LogoutInteractor implements LogoutUseCase {
  final IAuthRepository _repository;
  LogoutInteractor(this._repository);

  @override
  Future<void> call() => _repository.logout();
}
