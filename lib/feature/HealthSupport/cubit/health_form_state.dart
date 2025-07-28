abstract class HealthFormState {}

class HealthFormInitial extends HealthFormState {}

class HealthFormLoading extends HealthFormState {}

class HealthFormSuccess extends HealthFormState {}

class HealthFormFailure extends HealthFormState {
  final String errorMessage;
  HealthFormFailure({required this.errorMessage});

  @override
  String toString() => 'HealthFormFailure(errorMessage: $errorMessage)';
}

class HealthFormAlreadySubmitted extends HealthFormState {
  final double? daysRemaining;
  HealthFormAlreadySubmitted({this.daysRemaining});

  @override
  String toString() =>
      'HealthFormAlreadySubmitted(daysRemaining: $daysRemaining)';
}
