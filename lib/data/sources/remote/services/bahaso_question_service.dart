import 'package:bahaso_mobile_app/core/common/constants.dart';
import 'package:bahaso_mobile_app/data/sources/remote/responses/responses.dart';
import 'package:bahaso_mobile_app/data/sources/remote/services/services.dart';
import 'package:dio/dio.dart';

class BahasoQuestionService extends BaseService {
  BahasoQuestionService(super.dio);

  Future<GetQuestionsResponse> getQuestions() async {
    try {
      final response = await dio.get('/v2/quiz/attempt-data-general-english-example');
      return GetQuestionsResponse.fromMap(response.data);
    } on DioException catch (e) {
      logger.e(e.toString());
      throw exceptionHandler(e, onBadResponse: (data) {
        return data['error'];
      });
    }
  }
}
