import '../../di.dart';
import '../../domain/repositories/repositories.dart';
import '../repositories/repositories.dart';

Future<void> repositoryModule() async {
  // Register all repositories here
  getIt.registerSingleton<IAuthRepository>(AuthRepository(getIt.get(), getIt.get()));
}
