enum SyncStateType { none, syncing, synced, error, disabled }

class SyncState {
  SyncStateType type;
  String? error;

  SyncState({
    required this.type,
    this.error,
  });

  SyncState copyWith({
    SyncStateType Function()? type,
    String? Function()? error,
  }) {
    return SyncState(
      type: type != null ? type() : this.type,
      error: error != null ? error() : this.error,
    );
  }

  @override
  String toString() {
    return 'SyncState{type: $type, error: $error}';
  }
}
