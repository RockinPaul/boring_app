import 'package:boring_app/repositories/activity_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/activity.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository repository;
  ActivityCubit({required this.repository}) : super(const ActivityInitial());

  Future<void> appStarted() async {
    try {
      final totalActivitiesAvailable = repository.activities.length;
      emit(ActivityLoadInProgress(repository.currentPage));
      final fetchedActivities = await fetchData();
      emit( ActivityLoadSuccess(fetchedActivities));
    } catch (error) {
      emit(ActivityLoadFailure(error.toString()));
    }
  }
  // Method to fetch activities and update the state.
  Future<List<Activity>> fetchData() {
    return repository.fetchNextPage();
  }

  void fetchMore() {
    appStarted();
  }
}