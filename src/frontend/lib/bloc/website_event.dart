import 'package:equatable/equatable.dart';

abstract class WebsiteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WebsiteRefreshed extends WebsiteEvent {}
