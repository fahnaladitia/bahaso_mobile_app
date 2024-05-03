import 'package:bahaso_mobile_app/di.dart';
import 'package:bahaso_mobile_app/presentation/blocs/blocs.dart';
import 'package:bahaso_mobile_app/presentation/ui/home/bloc/questions_bloc.dart';

import 'package:bahaso_mobile_app/presentation/utils/toaster_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/models.dart';

import 'dialog/logout_confirmation_dialog.dart';
import 'views/bottom_nav_question.dart';
import 'views/question_description_display.dart';
import 'views/question_multiple_choice_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final QuestionsBloc _questionsBloc;

  @override
  void initState() {
    super.initState();
    _questionsBloc = getIt.get();
    _questionsBloc.add(QuestionsFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _questionsBloc,
      child: BlocConsumer<QuestionsBloc, QuestionsState>(
        listener: (context, state) {
          if (state is QuestionsError) {
            context.showToastError(state.message);
          }
        },
        builder: (context, state) {
          if (state is QuestionsEmpty) {
            return Scaffold(
              appBar: _appbar(context),
              body: const Center(child: Text('No questions available')),
            );
          }
          if (state is QuestionsLoading) {
            return Scaffold(
              appBar: _appbar(context),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is QuestionsLoaded) {
            return Scaffold(
              appBar: _appbar(context),
              body: _buildBody(state),
              bottomNavigationBar: BottomNavQuestion(
                questions: state.questions,
                currentIndex: state.currentQuestionIndex,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      title: const Text('Quiz App'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final result = await showLogoutConfirmationDialog(context);

            if (result == true && context.mounted) {
              context.read<AuthBloc>().add(AuthLogoutEvent());
            }
          },
        ),
      ],
    );
  }

  Widget _buildBody(QuestionsLoaded state) {
    switch (state.currentQuestion.runtimeType) {
      case MultipleChoiceQuestion:
        final question = state.currentQuestion as MultipleChoiceQuestion;
        return QuestionMultipleChoiceDisplay(question: question);
      case DescriptionQuestion:
        final question = state.currentQuestion as DescriptionQuestion;
        return QuestionDescriptionDisplay(question: question);
      default:
        return const SizedBox.shrink();
    }
  }
}
