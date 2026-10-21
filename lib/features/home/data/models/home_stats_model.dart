import '../../domain/entities/home_stats_entity.dart';

class HomeStatsModel extends HomeStatsEntity {
  const HomeStatsModel({
    required super.resolvedCount,
    required super.inProgressCount,
    required super.pendingCount,
  });

  factory HomeStatsModel.fromJson(Map<String, dynamic> json) {
    return HomeStatsModel(
      resolvedCount: json['resolved_count'] ?? 0,
      inProgressCount: json['in_progress_count'] ?? 0,
      pendingCount: json['pending_count'] ?? 0,
    );
  }
}