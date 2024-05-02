import 'package:bahaso_mobile_app/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/app/my_app.dart';
import 'presentation/utils/simple_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await injectDI();

  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}
