// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

sealed class QuestionData extends Equatable {
  const QuestionData();
  @override
  List<Object?> get props => [];
}

class QuestionDataChoice extends QuestionData {
  final String name;
  final int value;

  const QuestionDataChoice({
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [name, value];

  @override
  bool get stringify => true;
}

class QuestionDataPlace extends QuestionData {
  final String name;
  final QuestionDataChoice? choice;

  const QuestionDataPlace({
    required this.name,
    this.choice,
  });

  @override
  List<Object?> get props => [name, choice];

  @override
  bool get stringify => true;

  QuestionDataPlace copyWith({
    String? name,
    QuestionDataChoice? choice,
  }) {
    return QuestionDataPlace(
      name: name ?? this.name,
      choice: choice ?? this.choice,
    );
  }
}

class QuestionDataImage extends QuestionData {
  final String imageUrl;
  final int slot;

  const QuestionDataImage({
    required this.imageUrl,
    required this.slot,
  });

  @override
  List<Object?> get props => [imageUrl, slot];

  @override
  bool get stringify => true;
}
