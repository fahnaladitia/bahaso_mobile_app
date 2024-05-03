import 'package:bahaso_mobile_app/di.dart';

import '../blocs/blocs.dart';
import '../ui/home/bloc/questions_bloc.dart';
import '../ui/login/bloc/login_bloc.dart';
import '../ui/register/bloc/register_bloc.dart';

Future<void> blocsModule() async {
  getIt.registerFactory(() => RegisterBloc(getIt.get()));
  getIt.registerFactory(() => AuthBloc(getIt.get(), getIt.get()));
  getIt.registerFactory(() => LoginBloc(getIt.get()));
  getIt.registerFactory(() => QuestionsBloc(getIt.get()));
}
