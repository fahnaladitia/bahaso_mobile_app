import '../usecases.dart';

abstract class RegisterUseCase implements UseCaseWithParam<void, RegisterParams> {}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({
    required this.email,
    required this.password,
  });
}
