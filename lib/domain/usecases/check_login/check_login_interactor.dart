import '../../repositories/repositories.dart';
import 'check_login_usecase.dart';

class CheckLoginInteractor implements CheckLoginUseCase {
  final IAuthRepository _authRepository;
  CheckLoginInteractor(this._authRepository);

  @override
  Future<bool> call() async => await _authRepository.isLoggedIn();
}
