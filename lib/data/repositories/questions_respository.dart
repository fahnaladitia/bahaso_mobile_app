import 'package:bahaso_mobile_app/data/mappers/mappers.dart';
import 'package:bahaso_mobile_app/data/sources/remote/services/services.dart';
import 'package:bahaso_mobile_app/domain/models/question.dart';
import 'package:bahaso_mobile_app/domain/repositories/repositories.dart';

class QuestionsRepository implements IQuestionsRepository {
  final BahasoQuestionService _bahasoQuestionService;
  QuestionsRepository(this._bahasoQuestionService);
  @override
  Future<List<Question>> getQuestions() async {
    final response = await _bahasoQuestionService.getQuestions();
    return response.toDomains();
  }
}
