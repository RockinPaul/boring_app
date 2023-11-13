part of 'activity_cubit.dart';

sealed class ActivityState extends Equatable {
  const ActivityState();
}

final class ActivityInitial extends ActivityState {
  const ActivityInitial();

  @override
  List<Object?> get props => [];
}

/// Handling activities feed presentation
///
final class ActivityLoadInProgress extends ActivityState {
  final int page;

  const ActivityLoadInProgress(this.page);

  @override
  List<Object?> get props => [page];
}

final class ActivityLoadSuccess extends ActivityState {
  final List<Activity> activities;

  const ActivityLoadSuccess(this.activities);

  @override
  List<Object?> get props => [activities];
}

final class ActivityLoadFailure extends ActivityState {
  final String error;

  const ActivityLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// Select activity to show details.
///
final class ActivitySelectInProgress extends ActivityState {
  final Activity activityToShow;

  const ActivitySelectInProgress(this.activityToShow);

  @override
  List<Object?> get props => [activityToShow];
}

final class ActivitySelectSuccess extends ActivityState {
  final Activity selectedActivity;

  const ActivitySelectSuccess(this.selectedActivity);

  @override
  List<Object?> get props => [selectedActivity];
}

final class ActivitySelectFailure extends ActivityState {
  final String error;

  const ActivitySelectFailure(this.error);

  @override
  List<Object?> get props => [error];
}
