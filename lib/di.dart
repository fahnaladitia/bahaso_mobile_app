import 'package:get_it/get_it.dart';

import 'data/di/di.dart';
import 'domain/di/use_case_module.dart';
import 'presentation/di/blocs_module.dart';

final getIt = GetIt.instance;

Future<void> injectDI() async {
  await remoteModule();
  await repositoryModule();
  await useCaseModule();
  await blocsModule();
}
