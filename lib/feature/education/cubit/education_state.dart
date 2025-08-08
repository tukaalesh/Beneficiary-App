abstract class EducationRequestState {}

class EducationRequestInitial extends EducationRequestState {}

class EducationRequestLoading extends EducationRequestState {}

class EducationRequestSuccess extends EducationRequestState {}

class EducationRequestFailure extends EducationRequestState {
  final String message;
  EducationRequestFailure({required this.message});
}
 class EducationFormAlreadySubmitted extends EducationRequestState {
    final double? daysRemaining;
  EducationFormAlreadySubmitted({this.daysRemaining});

  @override
  String toString() =>
      'EducationFormAlreadySubmitted(daysRemaining: $daysRemaining)';
 }