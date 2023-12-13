import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/filter/filter_cubit.dart';
import '../../domain/models/filter.dart';

class FilterItem extends StatelessWidget {
  final ActivityType type;

  const FilterItem({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var isSelected = false;

    return BlocBuilder<FilterCubit, FilterState>(
      buildWhen: (previousState, currentState) {
        debugPrint('previousState for FilterItem in buildWhen: $previousState');
        debugPrint('currentState for FilterItem in buildWhen: $currentState');

        if (previousState is FilterInitial && type == ActivityType.all) {
          isSelected = true;
          return true;
        }

        if (currentState is FilterApplyInProgress) {
          final selectedType = currentState.filter.type;

          // Whether this item must be selected/unselected and therefore rebuilt.
          if ((selectedType == type && !isSelected) ||
              (selectedType != type && isSelected)) {
            isSelected = !isSelected;
            return true;
          }
          return false;
        }
        return false;
      },
      builder: (context, state) {
        debugPrint('Rebuilt for type: $type');
        return GestureDetector(
          onTap: () => context
              .read<FilterCubit>()
              .applyFilter(filter: Filter(type: type)),
          child: Container(
            width: 80.0,
            height: 80.0,
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                width: 3.0,
                color: Colors.white,
              ),
              color: isSelected ? Colors.white : Colors.orange.shade700,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type.icon,
                  color: isSelected ? Colors.orange.shade700 : Colors.white,
                ),
                AutoSizeText(
                  type.capitalizedName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                            isSelected ? Colors.orange.shade700 : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                  wrapWords: false,
                  minFontSize: 8.0,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
