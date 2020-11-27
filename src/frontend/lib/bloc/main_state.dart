import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainAnonymous extends MainState {}

class MainConnected extends MainState {
  final String password;

  @override
  List<Object> get props => [password];

  const MainConnected({this.password});
}
