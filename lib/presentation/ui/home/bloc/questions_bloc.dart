import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/models.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final List<Question> _questions = [];
  QuestionsBloc() : super(QuestionsInitial()) {
    on<QuestionsFetchEvent>((event, emit) async {
      emit(QuestionsLoading());
      try {
        await Future.delayed(const Duration(seconds: 2));
        const questions = dummyQuestions;
        if (questions.isEmpty) {
          emit(QuestionsEmpty());
        } else {
          _questions.addAll(questions);
          final firstQuestion = questions.first;
          if (firstQuestion is DescriptionQuestion) {
            final updatedQuestion = firstQuestion.selectToDisplay();
            _questions[_questions.indexOf(firstQuestion)] = updatedQuestion;
            emit(QuestionsLoaded(_questions, updatedQuestion, 0));
          } else {
            emit(QuestionsLoaded(_questions, firstQuestion, 0));
          }
        }
      } catch (e) {
        emit(QuestionsError(e.toString()));
      }
    });

    on<QuestionsMovieToQuestionEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        if (_questions.contains(event.question)) {
          if (event.question is DescriptionQuestion) {
            final descriptionQuestion = event.question as DescriptionQuestion;
            final updatedQuestion = descriptionQuestion.selectToDisplay();
            _questions[_questions.indexOf(event.question)] = updatedQuestion;
            emit(QuestionsLoaded(_questions, updatedQuestion, _questions.indexOf(updatedQuestion)));
          } else {
            emit(QuestionsLoaded(_questions, event.question, _questions.indexOf(event.question)));
          }
        }
      }
    });

    on<QuestionsNextEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        final currentIndex = _questions.indexOf(currentState.currentQuestion);
        if (currentIndex < _questions.length - 1) {
          final nextQuestion = _questions[currentIndex + 1];
          if (nextQuestion is DescriptionQuestion) {
            final updatedQuestion = nextQuestion.selectToDisplay();
            _questions[_questions.indexOf(nextQuestion)] = updatedQuestion;
            emit(QuestionsLoaded(_questions, updatedQuestion, currentIndex + 1));
          } else {
            emit(QuestionsLoaded(_questions, nextQuestion, currentIndex + 1));
          }
        }
      }
    });

    on<QuestionsPreviousEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        final currentIndex = _questions.indexOf(currentState.currentQuestion);
        if (currentIndex > 0) {
          final previousQuestion = _questions[currentIndex - 1];
          if (previousQuestion is DescriptionQuestion) {
            final updatedQuestion = previousQuestion.selectToDisplay();
            _questions[_questions.indexOf(previousQuestion)] = updatedQuestion;
            emit(QuestionsLoaded(_questions, updatedQuestion, currentIndex - 1));
          } else {
            emit(QuestionsLoaded(_questions, previousQuestion, currentIndex - 1));
          }
        }
      }
    });

    on<QuestionsSelectAnswerEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        final currentQuestion = currentState.currentQuestion;
        if (currentQuestion is MultipleChoiceQuestion && event.answer is TextAnswer) {
          final updatedQuestion = currentQuestion.selectAnswer(event.answer as TextAnswer);
          _questions[_questions.indexOf(currentQuestion)] = updatedQuestion;
          emit(QuestionsLoaded(_questions, updatedQuestion, _questions.indexOf(updatedQuestion)));
        }
      }
    });

    on<QuestionsUnselectAnswerEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        final currentQuestion = currentState.currentQuestion;
        if (currentQuestion is MultipleChoiceQuestion) {
          final updatedQuestion = currentQuestion.unselectAnswer();
          _questions[_questions.indexOf(currentQuestion)] = updatedQuestion;
          emit(QuestionsLoaded(_questions, updatedQuestion, _questions.indexOf(updatedQuestion)));
        }
      }
    });

    on<QuestionsSubmitEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        if (currentState.currentQuestion is MultipleChoiceQuestion) {
          final updatedQuestion = currentState.currentQuestion as MultipleChoiceQuestion;

          if (updatedQuestion.selectedAnswer == null) {
            return;
          }
          final submitted = updatedQuestion.submit();

          _questions[_questions.indexOf(updatedQuestion)] = submitted;
          emit(QuestionsLoaded(_questions, submitted, currentState.currentQuestionIndex));
        }
      }
    });

    on<QuestionsResetEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        final currentQuestion = currentState.currentQuestion;
        if (currentQuestion is MultipleChoiceQuestion) {
          final updatedQuestion = currentQuestion.reset();
          _questions[_questions.indexOf(currentQuestion)] = updatedQuestion;
          emit(QuestionsLoaded(_questions, updatedQuestion, _questions.indexOf(updatedQuestion)));
        }
      }
    });

    on<QuestionsSelectPuzzleTextAnswerEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        final currentQuestion = currentState.currentQuestion;
        if (currentQuestion is PuzzleTextQuestion) {
          final updatedQuestion = currentQuestion.selectAnswer(event.choice, event.place);
          _questions[currentState.currentQuestionIndex] = updatedQuestion;
          emit(QuestionsLoaded(
            _questions,
            _questions[currentState.currentQuestionIndex],
            currentState.currentQuestionIndex,
          ));
        }
      }
    });

    on<QuestionsRemovePuzzleTextAnswerEvent>((event, emit) {
      if (state is QuestionsLoaded) {
        final currentState = state as QuestionsLoaded;
        final currentQuestion = currentState.currentQuestion;
        if (currentQuestion is PuzzleTextQuestion) {
          final updatedQuestion = currentQuestion.removeAnswer(event.place);
          _questions[currentState.currentQuestionIndex] = updatedQuestion;
          emit(QuestionsLoaded(
            _questions,
            _questions[currentState.currentQuestionIndex],
            currentState.currentQuestionIndex,
          ));
        }
      }
    });
  }
}
