import 'package:flutter/widgets.dart';
import 'package:maco_monitor/domain/entity/Website.dart';
import 'package:maco_monitor/domain/usecase/GetAllWebsites.dart';
import 'package:maco_monitor/presentation/home/HomeState.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _state = BehaviorSubject<HomeState>.seeded(HomeState());
  HomeState getInitialState() => _state.value;
  Stream<HomeState> observeState() => _state.distinct();

  final _getAllWebsite = GetAllWebsites();

  HomeBloc(BuildContext buildContext) {
    _initState(buildContext);
  }
  Future<void> _initState(BuildContext context) async {
    List<Website> websites = await _getAllWebsite.invoke();
    _state.add(_state.value.buildNew(websites));
  }
}
