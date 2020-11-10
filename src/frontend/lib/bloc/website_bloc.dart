import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maco_monitor/bloc/bloc.dart';
import 'package:maco_monitor/domain/repository/WebsiteRepository.dart';

class WebsiteBloc extends Bloc<WebsiteEvent, WebsiteState> {
  WebsiteRepository websiteRepository;

  WebsiteBloc(this.websiteRepository) : super(WebsiteInitial());

  @override
  Stream<WebsiteState> mapEventToState(WebsiteEvent event) async* {
    if (event is WebsiteRefreshed) {
      yield WebsiteLoading();
      try {
        yield WebsiteSuccess(websites: await websiteRepository.getWebsites());
      } catch (_) {
        yield WebsiteFailure();
      }
    }
  }
}
