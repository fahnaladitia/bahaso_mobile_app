import '../models/models.dart';

abstract class IQuestionsRepository {
  Future<List<Question>> getQuestions();
}
