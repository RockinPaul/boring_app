import 'package:boring_app/data/api_service.dart';
import 'package:boring_app/data/local_storage_service.dart';
import '../data/models/activity.dart';

const _eventsPerPage = 10;

class ActivityRepository {
  final ApiService remoteDataSource;
  final LocalStorageService localDataSource;

  final _activities = <Activity>[];
  var _currentPage = 0;
  String? _activityType;
  double? _price;
  int? _participants;

  ActivityRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

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

  void updateFilter({
    String? type,
    double? price,
    int? participants,
  }) async {
    if (type != null && _activityType != type) {
      _activityType = type != 'all' ? type : null;
    }

    if (price != null && _price != price) {
      _price = price;
    }

    if (participants != null && _participants != _participants) {
      _participants = participants;
    }

    _currentPage = 0;
    _activities.clear();
  }

  List<Activity> get activities => _activities;

  String get activityType => _activityType ?? '';

  int get currentPage => _currentPage;

  int get participants => _participants ?? 0;

  double get price => _price ?? 0.0;
}
