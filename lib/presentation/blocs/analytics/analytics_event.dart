import 'package:equatable/equatable.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();
  @override
  List<Object?> get props => [];
}

class LoadAnalytics extends AnalyticsEvent {
  final String userId;
  const LoadAnalytics(this.userId);
  @override
  List<Object?> get props => [userId];
}
