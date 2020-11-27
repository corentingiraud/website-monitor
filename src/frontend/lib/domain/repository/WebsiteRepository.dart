import 'package:maco_monitor/domain/entity/Website.dart';

abstract class WebsiteRepository {
  String password;

  Future<List<Website>> getWebsites(String password);
}
