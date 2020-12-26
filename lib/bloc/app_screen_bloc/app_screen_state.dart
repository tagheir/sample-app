import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class AppScreenState extends AppState {}

// ignore: must_be_immutable
class AppScreenUninitializedState extends AppScreenState {}

// ignore: must_be_immutable
class AppScreenLoadingState extends AppScreenState {}

// ignore: must_be_immutable
class AppStateMainSplash extends AppScreenState {}

// ignore: must_be_immutable
class AppStateOnboarding extends AppScreenState {}

// ignore: must_be_immutable
class AppScreenSuccessState extends AppScreenState {
  final Widget screen;
  final AppState returnState;
  AppScreenSuccessState({this.screen, this.returnState});
}

// ignore: must_be_immutable
class AppScreenFailureState extends AppScreenState {
  final String str;
  AppScreenFailureState({this.str});
}

// ignore: must_be_immutable
class AppScreenRequestSubmittedState<T> extends AppScreenState {
  final T response;
  AppScreenRequestSubmittedState({this.response});
}

// ignore: must_be_immutable
class TaskProgressScreenState extends AppScreenState {
  final List<Function> tasks;
  TaskProgressScreenState({this.tasks});
}
