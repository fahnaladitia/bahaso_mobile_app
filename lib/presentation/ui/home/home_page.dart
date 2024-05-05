import 'package:bahaso_mobile_app/di.dart';
import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:bahaso_mobile_app/presentation/blocs/blocs.dart';
import 'package:bahaso_mobile_app/presentation/ui/home/bloc/questions_bloc.dart';
import 'package:bahaso_mobile_app/presentation/ui/home/views/build_display_question.dart';

import 'package:bahaso_mobile_app/presentation/utils/toaster_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialog/logout_confirmation_dialog.dart';
import 'views/bottom_nav_question.dart';

class HomePage extends StatefulWidget {
  final Auth auth;
  const HomePage({Key? key, required this.auth}) : super(key: key);

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
              body: BuildDisplayQuestion(question: state.currentQuestion),
              bottomNavigationBar: BottomNavQuestion(
                questions: state.questions,
                currentIndex: state.currentQuestionIndex,
              ),
            );
          }
          if (state is QuestionsError) {
            return Scaffold(
              appBar: _appbar(context),
              body: Center(
                child: Text(state.message),
              ),
            );
          }

          return const Scaffold(body: SizedBox.shrink());
        },
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/bahaso_logo.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${widget.auth.email}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Bahaso Language Learning App',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: false,
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
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(),
      ),
    );
  }
}
