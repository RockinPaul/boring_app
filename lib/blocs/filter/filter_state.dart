part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterApplyInProgress extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterApplySuccess extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterApplyFailure extends FilterState {
  @override
  List<Object> get props => [];
}