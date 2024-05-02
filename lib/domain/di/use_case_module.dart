import 'package:bahaso_mobile_app/di.dart';
import 'package:bahaso_mobile_app/domain/usecases/usecases.dart';

Future<void> useCaseModule() async {
  // Register all use cases here
  getIt.registerFactory<LoginUseCase>(() => LoginInteractor(getIt()));
  getIt.registerFactory<CheckLoginUseCase>(() => CheckLoginInteractor(getIt()));
  getIt.registerFactory<LogoutUseCase>(() => LogoutInteractor(getIt()));
}
