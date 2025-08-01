abstract class EducationRequestState {}

class EducationRequestInitial extends EducationRequestState {}

class EducationRequestLoading extends EducationRequestState {}

class EducationRequestSuccess extends EducationRequestState {}

class EducationRequestFailure extends EducationRequestState {
  final String message;

  EducationRequestFailure(this.message);
}
// class EducationFormAlreadySubmitted extends EducationRequestState {}

// class EducationFormPhoneNumberAlreadyUsed extends EducationRequestState {}