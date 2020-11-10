import 'package:equatable/equatable.dart';
import 'package:maco_monitor/domain/entity/Website.dart';

abstract class WebsiteState extends Equatable {
  const WebsiteState();

  @override
  List<Object> get props => [];
}

class WebsiteInitial extends WebsiteState {}

class WebsiteFailure extends WebsiteState {}

class WebsiteLoading extends WebsiteState {}

class WebsiteSuccess extends WebsiteState {
  final List<Website> websites;

  @override
  List<Object> get props => [websites];

  const WebsiteSuccess({this.websites});
}
