import 'package:maco_monitor/domain/entity/Website.dart';

class HomeState {
  final List<Website> allWebsites;

  const HomeState({this.allWebsites = const []});

  HomeState buildNew(List<Website> allWebsite) {
    return HomeState(allWebsites: allWebsite ?? allWebsite);
  }
}
