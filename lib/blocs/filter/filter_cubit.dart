import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/filter_repository.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterRepository repository;
  FilterCubit(this.repository) : super(FilterInitial());
}
