import 'package:auto_size_text/auto_size_text.dart';
import 'package:boring_app/blocs/activity/activity_cubit.dart';
import 'package:boring_app/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/filter/filter_cubit.dart';

enum ActivityType {
  all('all', Icons.search),
  recreational('recreational', Icons.golf_course),
  educational('educational', Icons.library_books),
  social('social', Icons.people),
  music('music', Icons.music_note),
  busywork('busywork', Icons.work),
  diy('diy', Icons.handyman),
  charity('charity', Icons.handshake),
  cooking('cooking', Icons.cake),
  relaxation('relaxation', Icons.flight_takeoff);

  const ActivityType(this.name, this.icon);

  final String name;
  final IconData icon;

  String get capitalizedName => name.capitalizeActivityType();
}

class FilterItem extends StatelessWidget {
  final ActivityType type;

  const FilterItem({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var isSelected = false;

    return BlocConsumer<FilterCubit, FilterState>(
      listenWhen: (previousState, currentState) {
        debugPrint(
            'previousState for filter item in listenWhen: $previousState');
        debugPrint('currentState for filter item in listenWhen: $currentState');
        return true;
      },
      listener: (context, state) {
        // TODO: implement listener
        // debugPrint('Filter state: $state');
      },
      buildWhen: (previousState, currentState) {
        debugPrint(
            'previousState for filter item in buildWhen: $previousState');
        debugPrint('currentState for filter item in buildWhen: $currentState');

        /// Checking whether some filter was selected.
        if (currentState is FilterTypeApplySuccess) {
          final appliedType = currentState.type;

          /// Handling initial selection.
          if (previousState is FilterInitial) {
            isSelected = appliedType == type;
            return isSelected;
          }

          /// Handling change of enabled filter.
          if (previousState is FilterTypeApplySuccess) {
            final previousType = previousState.type;
            /// Avoiding unnecessary rebuilds.
            ///
            /// for the FilterItem instances not involved in this state change
            /// and when FilterItem is already selected.
            if (appliedType != previousType &&
                (appliedType == type || previousType == type)) {
              isSelected = !isSelected && (appliedType == type);

              /// Triggering feed refresh.
              context.read<ActivityCubit>().fetchActivities();
              return true;
            }
          }
          return false;
        }
        return false;
      },
      builder: (context, state) {
        debugPrint('Rebuilt for type: $type');
        return GestureDetector(
          onTap: () => context.read<FilterCubit>().updateType(type),
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
