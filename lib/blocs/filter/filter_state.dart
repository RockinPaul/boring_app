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

  const FilterApplyInProgress({required this.filter});

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
  final Filter filter;
  const FilterApplySuccess(this.filter);

  @override
  List<Object> get props => [filter];
}

class FilterApplyFailure extends FilterState {
  final String error;

  const FilterApplyFailure(this.error);

  @override
  List<Object> get props => [error];
}

class FilterRetrieveInProgress extends FilterState {
  const FilterRetrieveInProgress();

  @override
  List<Object?> get props => [];
}

class FilterRetrieveSuccess extends FilterState {
  final Filter filter;

  const FilterRetrieveSuccess(this.filter);

  @override
  List<Object?> get props => [filter];
}

class FilterRetrieveFailure extends FilterState {
  final String error;

  const FilterRetrieveFailure(this.error);

  @override
  List<Object?> get props => [error];
}
