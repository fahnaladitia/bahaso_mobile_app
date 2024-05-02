import 'package:bahaso_mobile_app/data/sources/local/database/auth_database.dart';
import 'package:bahaso_mobile_app/di.dart';

Future<void> localModule() async {
  // Register all local data sources here
  final authDatabase = await AuthDatabase.instance();
  getIt.registerSingleton(authDatabase);
}
