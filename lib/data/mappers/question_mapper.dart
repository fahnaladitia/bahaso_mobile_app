import 'package:bahaso_mobile_app/core/common/constants.dart';
import 'package:bahaso_mobile_app/data/sources/remote/responses/responses.dart';
import 'package:bahaso_mobile_app/domain/models/models.dart';

extension QuestionsMapper on GetQuestionsResponse {
  List<Question> toDomains() {
    return data?.map((question) {
          switch (question.typequestion) {
            case 'description':
              return _mapDescriptionQuestion(question);
            case 'ddwtos':
              return _mapDDWTOSQuestion(question);
            case 'multichoice':
              return _mapMultipleChoiceQuestion(question);
            case 'truefalse':
              return _mapTrueFalseQuestion(question);
            case 'match':
              return _mapMatchQuestion(question);
            default:
              return _mapDescriptionQuestion(question);
          }
        }).toList() ??
        [];
  }

  DescriptionQuestion _mapDescriptionQuestion(GetQuestionsResponseDatum question) {
    final list = question.question as List<dynamic>;

    final mappedDisplays = list.map((e) {
      if (regexMp4.hasMatch(e)) {
        return VideoQuestionDisplay(videoUrl: e);
      }
      if (regexImage.hasMatch(e)) {
        return ImageQuestionDisplay(imageUrl: e);
      }
      if (regexAudio.hasMatch(e)) {
        return AudioQuestionDisplay(audioUrl: e);
      }

      return TextQuestionDisplay(text: e);
    }).toList();
    return DescriptionQuestion(
      questionDisplays: mappedDisplays,
      questionNumber: question.questionnumber.toString(),
    );
  }

  PuzzleTextQuestion _mapDDWTOSQuestion(GetQuestionsResponseDatum question) {
    final list = question.question as List<dynamic>;
    final data = GetQuestionsResponseDatumDataClass.fromMap(question.data);
    int count = 0;
    final mappedDisplays = list.map((e) {
      if (regexMp4.hasMatch(e)) {
        return VideoQuestionDisplay(videoUrl: e);
      }
      if (regexImage.hasMatch(e)) {
        return ImageQuestionDisplay(imageUrl: e);
      }
      if (regexAudio.hasMatch(e)) {
        return AudioQuestionDisplay(audioUrl: e);
      }

      final placesIds = <int>[];
      // Check if the blank

      final matches = blankRegex.allMatches(e);

      for (var match in matches) {
        final start = match.start;
        final end = match.end;
        final placeId = e.substring(start, end).trim();
        if (placeId == 'blank') {
          placesIds.add(count);
          count++;
        }
      }

      logger.d('placesIds $placesIds');

      if (placesIds.isNotEmpty) {
        return PuzzleTextQuestionDisplay(
          placesIds: placesIds,
          text: e,
          imageSlots: data.dataimage?.isNotEmpty == true ? placesIds : [],
        );
      }

      return TextQuestionDisplay(text: e);
    }).toList();

    final List<QuestionData> datas = [];

    final dataImages = data.dataimage;

    if (dataImages != null) {
      for (var i = 0; i < dataImages.length; i++) {
        final dataImage = dataImages[i];
        final image = dataImage.urlimage;
        final data = QuestionDataImage(imageUrl: image ?? '', slot: i);
        datas.add(data);
      }
    }

    logger.d('DataQuestionDataImage $datas');

    final dataPlaces = data.dataplace;

    if (dataPlaces != null) {
      for (var i = 0; i < dataPlaces.length; i++) {
        final dataPlace = dataPlaces[i];
        final name = dataPlace.name;
        final place = QuestionDataPlace(name: name ?? '');
        datas.add(place);
      }
    }

    final choices = data.datachoice;

    if (choices != null) {
      for (var i = 0; i < choices.length; i++) {
        final choice = choices[i];
        final name = choice.name ?? '';
        final choiceData = QuestionDataChoice(name: name, value: i);
        datas.add(choiceData);
        logger.d('$i.DataQuestionDataChoice $datas');
      }
    }

    return PuzzleTextQuestion(
      questionDisplays: mappedDisplays,
      questionNumber: question.questionnumber ?? '',
      data: datas,
    );
  }

  MultipleChoiceQuestion _mapMultipleChoiceQuestion(GetQuestionsResponseDatum question) {
    final list = question.question as List<dynamic>;
    final data = question.data as List<dynamic>;

    final correctAnswer = question.value;
    final mappedDisplays = list.map((e) {
      if (regexMp4.hasMatch(e)) {
        return VideoQuestionDisplay(videoUrl: e);
      }
      if (regexImage.hasMatch(e)) {
        return ImageQuestionDisplay(imageUrl: e);
      }
      if (regexAudio.hasMatch(e)) {
        return AudioQuestionDisplay(audioUrl: e);
      }

      return TextQuestionDisplay(text: e);
    }).toList();

    final List<QuestionDataText> mappedData = [];

    for (var i = 0; i < data.length; i++) {
      final dataTextMap = GetQuestionsResponseDatumDatatext.fromMap(data[i]);
      final name = dataTextMap.name ?? '';
      final value = dataTextMap.value ?? '';
      final text = dataTextMap.text ?? '';
      final dataText = QuestionDataText(text: text, name: name, value: value);
      mappedData.add(dataText);
    }

    return MultipleChoiceQuestion(
      questionDisplays: mappedDisplays,
      data: mappedData,
      correctAnswer: correctAnswer ?? '',
      questionNumber: question.questionnumber ?? '',
    );
  }

  MatchQuestion _mapMatchQuestion(GetQuestionsResponseDatum question) {
    final title = question.question;
    final data = GetQuestionsResponseDatumDataClass.fromMap(question.data);

    final mappedDisplays = [
      TextQuestionDisplay(text: title),
    ];

    final List<QuestionData> mappedData = [];

    final dataOptions = data.dataoptions;

    if (dataOptions != null) {
      List<String> options = [];
      for (var i = 0; i < dataOptions.length; i++) {
        final option = dataOptions[i];
        options.add(option);
      }

      logger.d('OptionsdataOptions $options');

      final dataOption = QuestionDataOptions(options);
      mappedData.add(dataOption);
    }

    final dataText = data.datatext;

    if (dataText != null) {
      for (var i = 0; i < dataText.length; i++) {
        final text = dataText[i].text ?? '';
        final name = dataText[i].name ?? '';

        final data = QuestionDataText(text: text, name: name, value: i.toString());
        mappedData.add(data);
      }
    }

    return MatchQuestion(
      questionDisplays: mappedDisplays,
      data: mappedData,
      questionNumber: question.questionnumber ?? '',
    );
  }

  TrueFalseQuestion _mapTrueFalseQuestion(GetQuestionsResponseDatum question) {
    final list = question.question as List<dynamic>;
    final data = question.data as List<dynamic>;

    final correctAnswer = question.value;
    final mappedDisplays = list.map((e) {
      if (regexMp4.hasMatch(e)) {
        return VideoQuestionDisplay(videoUrl: e);
      }
      if (regexImage.hasMatch(e)) {
        return ImageQuestionDisplay(imageUrl: e);
      }
      if (regexAudio.hasMatch(e)) {
        return AudioQuestionDisplay(audioUrl: e);
      }

      return TextQuestionDisplay(text: e);
    }).toList();

    final List<QuestionDataTrueFalse> mappedData = data.map((e) {
      logger.d('DataQuestionDataTrueFalse $e');
      final dataText = GetQuestionsResponseDatumDatatext.fromMap(e);
      final name = dataText.name ?? '';
      final value = dataText.value ?? '';
      final status = dataText.text == 'True';
      return QuestionDataTrueFalse(name: name, value: value, status: status);
    }).toList();

    return TrueFalseQuestion(
      questionDisplays: mappedDisplays,
      data: mappedData,
      correctAnswer: correctAnswer ?? '',
      questionNumber: question.questionnumber ?? '',
    );
  }
}
