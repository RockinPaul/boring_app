part of 'activity_cubit.dart';

sealed class ActivityState extends Equatable {
  const ActivityState();
}

final class ActivityInitial extends ActivityState {
  const ActivityInitial();
  @override
  List<Object?> get props => [];
}

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
  // TODO: implement props
  List<Object?> get props => [error];
}