import 'package:charity_app/feature/request_status/request_status/model/request_status_model.dart';

abstract class RequestStatusState {}

class RequestStatusInitial extends RequestStatusState {}

class RequestStatusLoading extends RequestStatusState {}

class RequestStatusSuccess extends RequestStatusState {
  final List<RequestStatusModel> projects;

  RequestStatusSuccess(this.projects);
}

class RequestStatusError extends RequestStatusState {
  final String message;

  RequestStatusError(this.message);
}
