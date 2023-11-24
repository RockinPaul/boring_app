part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterApplyInProgress extends FilterState {
  final Filter filter;

  const FilterApplyInProgress(this.filter);
  @override
  List<Object> get props => [filter];
}

class FilterTypeApplySuccess extends FilterState {
  final ActivityType type;

  const FilterTypeApplySuccess(this.type);

  @override
  List<Object> get props => [type];
}

class FilterApplySuccess extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterApplyFailure extends FilterState {
  final String error;
  const FilterApplyFailure(this.error);
  @override
  List<Object> get props => [error];
}