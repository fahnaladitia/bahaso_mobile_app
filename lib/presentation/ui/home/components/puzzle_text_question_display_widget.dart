import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:bahaso_mobile_app/domain/utils/question_ext.dart';
import 'package:flutter/material.dart';

import '../../../components/components.dart';

class PuzzleTextQuestionDisplayWidget extends StatelessWidget {
  final PuzzleTextQuestionDisplay questionDisplay;
  final PuzzleTextQuestion question;
  const PuzzleTextQuestionDisplayWidget({
    Key? key,
    required this.questionDisplay,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = questionDisplay.image(question);
    final places = questionDisplay.places(question);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (image != null)
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.only(right: 8),
                child: BasicCachedImage(imageUrl: image.imageUrl, fit: BoxFit.fitWidth),
              ),
            Text(questionDisplay.display(places)),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
