import '../../data/models/checklist_model.dart';

abstract class ChecklistState {}

class ChecklistInitial extends ChecklistState {}

class ChecklistLoading extends ChecklistState {}

class ChecklistsLoaded extends ChecklistState {
  final List<ChecklistModel> checklists;
  ChecklistsLoaded(this.checklists);
}

class ChecklistSubmitting extends ChecklistState {}

class ChecklistSubmitSuccess extends ChecklistState {}

class ChecklistSubmitBlocked extends ChecklistState {
  final String reason;
  ChecklistSubmitBlocked(this.reason);
}

class ChecklistError extends ChecklistState {
  final String message;
  ChecklistError(this.message);
}
