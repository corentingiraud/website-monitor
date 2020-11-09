import 'package:maco_monitor/domain/entity/Website.dart';
import 'package:maco_monitor/presentation/App.dart';

class GetAllWebsites {
  final _websiteRepository = dependencies.websiteRepository;

  Future<List<Website>> invoke() {
    return _websiteRepository.getWebsites();
  }
}
