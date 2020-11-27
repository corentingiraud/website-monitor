import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MainSubmitPassword extends MainEvent {
  final String password;

  MainSubmitPassword(this.password);
}

class MainLogout extends MainEvent {}
