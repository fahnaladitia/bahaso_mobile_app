import 'package:bahaso_mobile_app/di.dart';

import '../blocs/blocs.dart';
import '../ui/login/bloc/login_bloc.dart';
import '../ui/register/bloc/register_bloc.dart';

Future<void> blocsModule() async {
  getIt.registerFactory(() => RegisterBloc());
  getIt.registerFactory(() => AuthBloc(getIt.get(), getIt.get()));
  getIt.registerFactory(() => LoginBloc(getIt.get()));
}
