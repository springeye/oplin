import 'package:equatable/equatable.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class SyncSubscriptionRequested extends SyncEvent {
  final dynamic server;

  const SyncSubscriptionRequested(this.server);
}
