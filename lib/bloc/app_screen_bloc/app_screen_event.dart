import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/response_model.dart';
import 'package:flutter/material.dart';

abstract class AppScreenEvent {}

class AppScreenLoadingEvent extends AppScreenEvent {}

class AppScreenSuccessEvent extends AppScreenEvent {}

class AppScreenFailureEvent extends AppScreenEvent {}

class AppScreenRequestEvent extends AppScreenEvent {
  ScreenData screenData;
  Future<ResponseModel<dynamic>> Function() function;
  Widget screenView;
  AppScreenRequestEvent({this.function});
}

class TaskProgressScreenEvent extends AppScreenEvent {
  final List<Function> tasks;
  TaskProgressScreenEvent({this.tasks});
}
