import 'package:boring_app/repositories/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/filter.dart';
import '../../presentation/components/filter_item.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final ActivityRepository repository;

  FilterCubit({required this.repository}) : super(FilterInitial());

  void applyFilters({
    required String selectedType,
    required double selectedPrice,
    required int selectedParticipants,
  }) {
    // Add logic to apply filters here
    // Typically, you would emit FilterApplyInProgress, make the API request,
    // then emit FilterApplySuccess or FilterApplyFailure based on the result.
  }

  void updateType(ActivityType type) async {
    debugPrint('Activity of type selected: ${type.name}');
    repository.updateFilter(type: type.name);
    emit(FilterTypeApplySuccess(type));
  }

  void updateAccessibility(double accessibility) {
    emit(FilterApplySuccess());
  }

  void updatePrice(double price) {
    emit(FilterApplySuccess());
  }

  void updateParticipants(int participants) {
    emit(FilterApplySuccess());
  }
}
