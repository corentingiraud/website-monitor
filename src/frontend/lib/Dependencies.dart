import 'data/WebsiteRepositoryImpl.dart';
import 'domain/repository/WebsiteRepository.dart';

class Dependencies {
  final WebsiteRepository websiteRepository = WebsiteRepositoryImpl();
}
