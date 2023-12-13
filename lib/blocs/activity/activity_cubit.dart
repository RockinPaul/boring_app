import 'package:boring_app/data/repositories/activity_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/activity.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository repository;

  ActivityCubit({required this.repository}) : super(const ActivityInitial());

  // Method to fetch activities and update the state.
  Future<void> fetchActivities() async {
    try {
      emit(ActivityLoadInProgress(repository.currentPage));
      final fetchedActivities = await repository.fetchNextPage();
      emit(ActivityLoadSuccess(fetchedActivities));
    } catch (error) {
      emit(ActivityLoadFailure(error.toString()));
    }
  }

  void showDetails({required Activity activity}) {
    emit(ActivitySelectInProgress(activity));
    try {
      emit(ActivitySelectSuccess(activity));
    } catch (error) {
      final errorDescription =
          'Unable to select an activity: ${error.toString()}';
      emit(ActivitySelectFailure(errorDescription));
    }
  }
}
