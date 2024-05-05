import '../../models/models.dart';
import '../../repositories/repositories.dart';
import 'check_login_usecase.dart';

class CheckLoginInteractor implements CheckLoginUseCase {
  final IAuthRepository _authRepository;
  CheckLoginInteractor(this._authRepository);

  @override
  Future<Auth?> call() async => await _authRepository.getLoggedInAuth();
}
