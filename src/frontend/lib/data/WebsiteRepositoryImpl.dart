import 'package:maco_monitor/data/helpers/unauthorized_exception.dart';
import 'package:maco_monitor/domain/entity/Website.dart';
import 'package:maco_monitor/domain/repository/WebsiteRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebsiteRepositoryImpl implements WebsiteRepository {
  String password;

  @override
  Future<List<Website>> getWebsites(String password) async {
    final response = await http.get(
      'http://192.168.1.35:5001/able-stock-267514/us-central1/checkWebsites',
      headers: {'Authorization': 'Bearer $password'},
    );

    switch (response.statusCode) {
      case 200:
        var l = json.decode(response.body);
        List<Website> websites =
            List<Website>.from(l.map((i) => Website.fromJson(i)));
        return websites;
      case 403:
        throw UnauthorizedException('Failed to load websites');
      default:
        throw Exception('Failed to load websites');
    }
  }
}
