import 'package:maco_monitor/domain/entity/Website.dart';

abstract class WebsiteRepository {
  Future<List<Website>> getWebsites();
}
