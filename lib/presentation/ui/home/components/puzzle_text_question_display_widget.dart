import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

class PuzzleTextQuestionDisplayWidget extends StatelessWidget {
  final PuzzleTextQuestionDisplay questionDisplay;
  final QuestionDataImage? image;
  final List<QuestionDataPlace> places;
  const PuzzleTextQuestionDisplayWidget({
    Key? key,
    required this.questionDisplay,
    required this.places,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Image.network(image!.imageUrl),
              ),
            Text(questionDisplay.display(places)),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
