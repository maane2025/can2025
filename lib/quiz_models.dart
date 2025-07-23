// Quiz Models for Flutter

class MultipleChoiceQuestion {
  final String id;
  final String question;
  final List<String> options;
  final String answer;

  MultipleChoiceQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      answer: json['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'answer': answer,
    };
  }
}

class MatchingPair {
  final String id;
  final String item1;
  final String item2;

  MatchingPair({
    required this.id,
    required this.item1,
    required this.item2,
  });

  factory MatchingPair.fromJson(Map<String, dynamic> json) {
    return MatchingPair(
      id: json['id'] ?? '',
      item1: json['item1'] ?? '',
      item2: json['item2'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item1': item1,
      'item2': item2,
    };
  }
}

class MatchingQuestion {
  final String id;
  final String instruction;
  final List<MatchingPair> pairs;

  MatchingQuestion({
    required this.id,
    required this.instruction,
    required this.pairs,
  });

  factory MatchingQuestion.fromJson(Map<String, dynamic> json) {
    return MatchingQuestion(
      id: json['id'] ?? '',
      instruction: json['instruction'] ?? '',
      pairs: (json['pairs'] as List<dynamic>?)
          ?.map((pair) => MatchingPair.fromJson(pair))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instruction': instruction,
      'pairs': pairs.map((pair) => pair.toJson()).toList(),
    };
  }
}

class TimelineEvent {
  final String id;
  final int year;
  final String description;
  final int correctOrder;

  TimelineEvent({
    required this.id,
    required this.year,
    required this.description,
    required this.correctOrder,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
      id: json['id'] ?? '',
      year: json['year'] ?? 0,
      description: json['description'] ?? '',
      correctOrder: json['correctOrder'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
      'description': description,
      'correctOrder': correctOrder,
    };
  }
}

class TimelineQuestion {
  final String id;
  final String instruction;
  final List<TimelineEvent> events;

  TimelineQuestion({
    required this.id,
    required this.instruction,
    required this.events,
  });

  factory TimelineQuestion.fromJson(Map<String, dynamic> json) {
    return TimelineQuestion(
      id: json['id'] ?? '',
      instruction: json['instruction'] ?? '',
      events: (json['events'] as List<dynamic>?)
          ?.map((event) => TimelineEvent.fromJson(event))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instruction': instruction,
      'events': events.map((event) => event.toJson()).toList(),
    };
  }
}

enum QuizType {
  multipleChoice,
  matching,
  timeline,
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final QuizType type;
  final List<MultipleChoiceQuestion>? multipleChoiceQuestions;
  final List<MatchingQuestion>? matchingQuestions;
  final List<TimelineQuestion>? timelineQuestions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.multipleChoiceQuestions,
    this.matchingQuestions,
    this.timelineQuestions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String?;
    QuizType type;
    
    switch (typeString) {
      case 'multiple-choice':
        type = QuizType.multipleChoice;
        break;
      case 'matching':
        type = QuizType.matching;
        break;
      case 'timeline':
        type = QuizType.timeline;
        break;
      default:
        throw Exception('Unknown quiz type: $typeString');
    }

    return Quiz(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: type,
      multipleChoiceQuestions: type == QuizType.multipleChoice
          ? (json['questions'] as List<dynamic>?)
              ?.map((q) => MultipleChoiceQuestion.fromJson(q))
              .toList()
          : null,
      matchingQuestions: type == QuizType.matching
          ? (json['questions'] as List<dynamic>?)
              ?.map((q) => MatchingQuestion.fromJson(q))
              .toList()
          : null,
      timelineQuestions: type == QuizType.timeline
          ? (json['questions'] as List<dynamic>?)
              ?.map((q) => TimelineQuestion.fromJson(q))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'description': description,
    };

    switch (type) {
      case QuizType.multipleChoice:
        data['type'] = 'multiple-choice';
        data['questions'] = multipleChoiceQuestions?.map((q) => q.toJson()).toList();
        break;
      case QuizType.matching:
        data['type'] = 'matching';
        data['questions'] = matchingQuestions?.map((q) => q.toJson()).toList();
        break;
      case QuizType.timeline:
        data['type'] = 'timeline';
        data['questions'] = timelineQuestions?.map((q) => q.toJson()).toList();
        break;
    }

    return data;
  }
} 