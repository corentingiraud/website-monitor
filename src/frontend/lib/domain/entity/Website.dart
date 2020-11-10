import 'package:equatable/equatable.dart';

class Website extends Equatable {
  final String name;
  final String url;
  final bool isUp;

  Website({this.name = '', this.url = '', this.isUp = false});
  factory Website.fromJson(Map<dynamic, dynamic> json) {
    return Website(
      name: json['name'],
      url: json['url'],
      isUp: json['isUp'],
    );
  }

  @override
  List<Object> get props => [name, url, isUp];
}
