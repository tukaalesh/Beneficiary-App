abstract class NutritionalRequestState {}

class NutritionalRequestInitial extends NutritionalRequestState {}

class NutritionalRequestLoading extends NutritionalRequestState {}

class NutritionalRequestSuccess extends NutritionalRequestState {}

class NutritionalRequestFailure extends NutritionalRequestState {
  final String message;
  NutritionalRequestFailure({required this.message});
}

 class NutritionalFormAlreadySubmitted extends NutritionalRequestState {
      final double? daysRemaining;
  NutritionalFormAlreadySubmitted({this.daysRemaining});
 }