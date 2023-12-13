import 'package:boring_app/data/data_sources/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/activity.dart';
import '../../domain/models/filter.dart';

const _eventsPerPage = 10;

class ActivityRepository {
  final ApiService remoteDataSource;

  final _activities = <Activity>[];
  var _currentPage = 0;
  String? _activityType;
  double? _price;
  int? _participants;

  ActivityRepository({required this.remoteDataSource});

  Future<List<Activity>> fetchNextPage() async {
    final nextPageActivities = await remoteDataSource.fetchRandomActivities(
      _eventsPerPage,
      type: _activityType,
      price: _price,
      participants: _participants,
    );
    _activities.addAll(nextPageActivities);
    _currentPage++;

    return _activities;
  }

  void updateFilter({Filter? filter}) {
    final type = filter?.type;
    final price = filter?.price;
    final participants = filter?.participants;

    debugPrint(
        'updateFilter: type = $type, price = $price, participants = $participants');

    if (type != null && _activityType != type.name) {
      _activityType = type.name;
    }

    if (price != null && _price != price) {
      _price = price < 0.1 ? null : price;
    }

    if (participants != null && _participants != participants) {
      _participants = participants != 0 ? participants : null;
    }

    _currentPage = 0;
    _activities.clear();
  }

  void updateActivityType(String type) {
    _activityType = type;
  }

  void updatePrice(double price) {
    _price = price;
  }

  void updateParticipants(int participants) {
    _participants = participants;
  }

  Filter retrieveFilter() {
    // Mapping a String value of Activity type
    // to available enum representation in ActivityType.
    final activityPresentationType = ActivityType.values.firstWhere(
      (element) => element.name == _activityType!,
    );
    final currentFilter = Filter(
      type: activityPresentationType,
      price: _price,
      participants: _participants,
    );
    return currentFilter;
  }

  List<Activity> get activities => _activities;

  String get activityType => _activityType ?? '';

  int get currentPage => _currentPage;

  int get participants => _participants ?? 0;

  double get price => _price ?? 0.0;
}
