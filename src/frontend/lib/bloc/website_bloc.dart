import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/data/helpers/unauthorized_exception.dart';
import 'package:maco_monitor/domain/repository/WebsiteRepository.dart';

class WebsiteBloc extends Bloc<WebsiteEvent, WebsiteState> {
  final MainBloc mainBloc;
  StreamSubscription mainBlocSubscription;

  WebsiteRepository websiteRepository;

  WebsiteBloc({@required this.websiteRepository, @required this.mainBloc})
      : super(WebsiteLoading()) {
    mainBlocSubscription = mainBloc.listen((state) {
      if (state is MainConnected) {
        add(WebsiteRefreshed(state.password));
      }
    });
  }

  @override
  Stream<WebsiteState> mapEventToState(WebsiteEvent event) async* {
    if (event is WebsiteRefreshed) {
      yield WebsiteLoading();
      try {
        yield WebsiteSuccess(
            websites: await websiteRepository.getWebsites(event.password));
      } catch (e) {
        if (e is UnauthorizedException) {
          yield WebsiteFailure(wrongPassword: true);
        }
        yield WebsiteFailure();
      }
    }
  }

  @override
  Future<void> close() {
    mainBlocSubscription.cancel();
    return super.close();
  }
}
