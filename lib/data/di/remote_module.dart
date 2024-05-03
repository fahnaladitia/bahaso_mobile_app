import 'package:bahaso_mobile_app/data/sources/remote/config/app_rest_client.dart';
import 'package:bahaso_mobile_app/data/sources/remote/services/services.dart';
import 'package:bahaso_mobile_app/di.dart';
import 'package:dio/dio.dart';

import '../../core/common/constants.dart';

const regresDioClient = 'regresDioClient';
const bahasoDioClient = 'bahasoDioClient';

Future<void> remoteModule() async {
  final regresClient = AppRestClient(baseURL: reqresAPI);
  final bahasoClient = AppRestClient(baseURL: bahasoAPI);

  getIt.registerSingleton<Dio>(regresClient.dio, instanceName: regresDioClient);
  getIt.registerSingleton<Dio>(bahasoClient.dio, instanceName: bahasoDioClient);

  getIt.registerSingleton(AuthService(getIt.get(instanceName: regresDioClient)));
  getIt.registerSingleton(BahasoQuestionService(getIt.get(instanceName: bahasoDioClient)));
}
