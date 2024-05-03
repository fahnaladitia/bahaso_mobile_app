import 'package:bahaso_mobile_app/domain/models/question.dart';
import 'package:bahaso_mobile_app/domain/repositories/repositories.dart';

import 'questions_usecase.dart';

class QuestionsInteractor implements QuestionsUseCase {
  final IQuestionsRepository _repository;
  QuestionsInteractor(this._repository);

  @override
  Future<List<Question>> call() => _repository.getQuestions();
}
