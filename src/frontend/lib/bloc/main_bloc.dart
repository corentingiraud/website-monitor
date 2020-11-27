import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainAnonymous());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainSubmitPassword) {
      yield MainConnected(password: event.password);
    }
    if (event is MainLogout) {
      yield MainAnonymous();
    }
  }
}
