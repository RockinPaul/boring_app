import 'package:boring_app/repositories/activity_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/filter.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final ActivityRepository repository;

  FilterCubit({required this.repository}) : super(FilterInitial());

  void applyFilter({
    required Filter filter,
  }) {
    emit(FilterApplyInProgress(filter: filter));
    final previouslySelectedType = repository.activityType;
    final previouslySelectedPrice = repository.price;
    final previouslySelectedParticipants = repository.participants;

    repository.updateFilter(filter: filter);

    // debugPrint('Previously selected type: $previouslySelectedType');
    // debugPrint('Previously selected price: $previouslySelectedPrice');
    // debugPrint(
    //     'Previously selected participants: $previouslySelectedParticipants');
    //
    // debugPrint('Currently selected type: ${filter.type?.name}');
    // debugPrint('Currently selected price: ${filter.price}');
    // debugPrint('Currently selected participants: ${filter.participants}');

    if (filter.type != null && repository.activityType != filter.type?.name) {
      emit(FilterTypeApplySuccess(filter.type!));
    }
    emit(FilterApplySuccess(filter));
  }

  void retrieveFilter() {
    emit(const FilterRetrieveInProgress());
    final filter = repository.retrieveFilter();

    final previouslySelectedType = filter.type;
    final previouslySelectedPrice = filter.price;
    final previouslySelectedParticipants = filter.participants;

    emit(FilterRetrieveSuccess(Filter(
      type: previouslySelectedType,
      price: previouslySelectedPrice,
      participants: previouslySelectedParticipants,
    )));
  }
}
