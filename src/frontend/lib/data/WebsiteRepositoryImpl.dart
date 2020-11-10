import 'package:maco_monitor/domain/entity/Website.dart';
import 'package:maco_monitor/domain/repository/WebsiteRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebsiteRepositoryImpl implements WebsiteRepository {
  @override
  Future<List<Website>> getWebsites() async {
    final response = await http.get('http://192.168.1.35:3000/websites');
    if (response.statusCode == 200) {
      var l = json.decode(response.body);
      List<Website> websites =
          List<Website>.from(l.map((i) => Website.fromJson(i)));
      return websites;
    } else {
      throw Exception('Failed to load websites');
    }
  }
}
