import 'package:maco_monitor/domain/entity/Website.dart';
import 'package:maco_monitor/domain/repository/WebsiteRepository.dart';

class WebsiteRepositoryImpl implements WebsiteRepository {
  @override
  Future<List<Website>> getWebsites() {
    return Future.delayed(
        const Duration(seconds: 2),
        () => List.filled(
            1,
            Website(
                name: 'MacoMaco',
                url: 'https://macomaco.studio',
                isUp: false)));
  }
}
