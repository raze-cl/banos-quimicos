class ChecklistQuestionOptionModel {
  final String id;
  final String questionId;
  final String optionText;
  final bool isCriticalTrigger;

  ChecklistQuestionOptionModel({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isCriticalTrigger,
  });

  factory ChecklistQuestionOptionModel.fromJson(Map<String, dynamic> json) {
    return ChecklistQuestionOptionModel(
      id: json['id'] as String,
      questionId: json['questionId'] as String,
      optionText: json['optionText'] as String,
      isCriticalTrigger: json['isCriticalTrigger'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'optionText': optionText,
      'isCriticalTrigger': isCriticalTrigger,
    };
  }
}

class ChecklistQuestionModel {
  final String id;
  final String checklistId;
  final String questionText;
  final String questionType; // YES_NO, MULTIPLE_CHOICE, TEXT, NUMBER, PHOTO, SIGNATURE
  final bool isRequired;
  final bool isCritical;
  final int sortOrder;
  final List<ChecklistQuestionOptionModel> options;

  ChecklistQuestionModel({
    required this.id,
    required this.checklistId,
    required this.questionText,
    required this.questionType,
    required this.isRequired,
    required this.isCritical,
    required this.sortOrder,
    this.options = const [],
  });

  factory ChecklistQuestionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> optsJson = json['options'] ?? [];
    return ChecklistQuestionModel(
      id: json['id'] as String,
      checklistId: json['checklistId'] as String,
      questionText: json['questionText'] as String,
      questionType: json['questionType'] as String,
      isRequired: json['isRequired'] as bool? ?? true,
      isCritical: json['isCritical'] as bool? ?? false,
      sortOrder: json['sortOrder'] as int? ?? 0,
      options: optsJson.map((e) => ChecklistQuestionOptionModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklistId': checklistId,
      'questionText': questionText,
      'questionType': questionType,
      'isRequired': isRequired,
      'isCritical': isCritical,
      'sortOrder': sortOrder,
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class ChecklistModel {
  final String id;
  final String title;
  final String? description;
  final int version;
  final List<ChecklistQuestionModel> questions;

  ChecklistModel({
    required this.id,
    required this.title,
    this.description,
    required this.version,
    this.questions = const [],
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> qsJson = json['questions'] ?? [];
    return ChecklistModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      version: json['version'] as int? ?? 1,
      questions: qsJson.map((e) => ChecklistQuestionModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'version': version,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}
