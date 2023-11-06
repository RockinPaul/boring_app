import 'dart:convert';

import 'package:boring_app/data/api_service.dart';
import 'package:boring_app/data/local_storage_service.dart';
import '../data/models/activity.dart';

const _eventsPerPage = 10;

class ActivityRepository {
  final ApiService remoteDataSource;
  final LocalStorageService localDataSource;

  final _activities = <Activity>[];
  var _currentPage = 0;

  ActivityRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<Activity>> fetchNextPage() async {
    final nextPageActivities =
        await remoteDataSource.fetchRandomActivities(_eventsPerPage);
    _activities.addAll(nextPageActivities);
    _currentPage++;

    return _activities;
  }

  List<Activity> get activities => _activities;
  int get currentPage => _currentPage;
}
