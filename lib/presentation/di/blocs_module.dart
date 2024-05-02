import 'package:bahaso_mobile_app/di.dart';

import '../ui/register/bloc/register_bloc.dart';

Future<void> blocsModule() async {
  getIt.registerFactory(() => RegisterBloc());
}
