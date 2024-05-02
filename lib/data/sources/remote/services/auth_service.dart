import 'package:bahaso_mobile_app/data/sources/remote/responses/responses.dart';
import 'package:dio/dio.dart';

import 'base_service.dart';

class AuthService extends BaseService {
  AuthService(super.dio);

  Future<PostLoginResponse> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return PostLoginResponse.fromMap(response.data);
    } on DioException catch (e) {
      throw exceptionHandler(e, onBadResponse: (data) {
        return data['error'];
      });
    }
  }
}
