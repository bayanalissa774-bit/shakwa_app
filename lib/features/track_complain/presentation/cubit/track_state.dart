import 'package:flutter/foundation.dart';

import '../../domain/entities/track_entity.dart';

@immutable
abstract class TrackState {}

class TrackInitial extends TrackState {}

class TrackLoading extends TrackState {}

class TrackLoaded extends TrackState {
  final TrackEntity complaint;
  TrackLoaded(this.complaint);
}

class TrackError extends TrackState {
  final String message;
  TrackError(this.message);
}
