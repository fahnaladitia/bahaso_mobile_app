import '../usecases.dart';

abstract class LoginUseCase implements UseCaseWithParam<void, LoginParams> {}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
