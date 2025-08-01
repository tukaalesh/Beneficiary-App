abstract class HousingFormState {}

class HousingFormInitial extends HousingFormState {}

class HousingFormLoading extends HousingFormState {}

class HousingFormSuccess extends HousingFormState {}

class HousingFormFailure extends HousingFormState {
  final String errorMessage;
  HousingFormFailure({required this.errorMessage});

  @override
  String toString() => 'HousingFormFailure(errorMessage: $errorMessage)';
}

class HousingFormAlreadySubmitted extends HousingFormState {
  final double? daysRemaining;
  HousingFormAlreadySubmitted({this.daysRemaining});

  @override
  String toString() =>
      'HousingFormAlreadySubmitted(daysRemaining: $daysRemaining)';
}
