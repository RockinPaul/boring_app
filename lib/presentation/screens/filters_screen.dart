import 'package:auto_size_text/auto_size_text.dart';
import 'package:boring_app/blocs/activity/activity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/filter/filter_cubit.dart';
import '../../data/models/filter.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // String _selectedType = 'all';
  ActivityType _selectedType = ActivityType.all;
  double _selectedPrice = 0.0;
  int _selectedParticipants = 0;

  bool _isRetrieved = false;

  final TextEditingController participantsController =
      TextEditingController(text: '0');

  // final TextEditingController filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<FilterCubit>().retrieveFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
      ),
      body: BlocConsumer<FilterCubit, FilterState>(
        listener: (BuildContext context, FilterState state) {
          debugPrint('FiltersScreen state in listener: $state');
          if (state is FilterApplySuccess) {
            context.read<ActivityCubit>().fetchActivities();
            Navigator.of(context).pop();
          }
        },
        buildWhen: (previousState, currentState) {
          debugPrint('FiltersScreen, buildWhen previous state: $previousState');
          debugPrint('FiltersScreen, buildWhen current state: $currentState');
          return true;
        },
        builder: (context, state) {
          debugPrint('FiltersScreen state in builder: $state');

          if (state is FilterRetrieveSuccess && !_isRetrieved) {
            debugPrint('FilterRetrieveSuccess!');
            final retrievedFilter = state.filter;
            final type = retrievedFilter.type;
            final price = retrievedFilter.price;
            final participants = retrievedFilter.participants;

            if (type != null) {
              _selectedType = type;
            }
            if (price != null) {
              _selectedPrice = price;
            }
            if (participants != null) {
              _selectedParticipants = participants;
            }

            _isRetrieved = true;

            debugPrint('Retrieved type: $_selectedType');
            debugPrint('Retrieved price: $_selectedPrice');
            debugPrint('Retrieved participants: $_selectedParticipants');
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      'Activity type',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  /// Activity type dropdown menu
                  Flexible(
                    child: DropdownMenu<ActivityType>(
                      enableFilter: false,
                      requestFocusOnTap: false,
                      leadingIcon: Icon(_selectedType.icon),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.orange.shade700),
                      expandedInsets: EdgeInsets.zero,
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5.0),
                        suffixIconColor: Colors.orange.shade700,
                        prefixIconColor: Colors.orange.shade700,
                      ),
                      initialSelection: _selectedType,
                      onSelected: (ActivityType? activityType) {
                        if (activityType != null) {
                          setState(() {
                            _selectedType = activityType;
                          });
                        }
                      },
                      dropdownMenuEntries: ActivityType.values
                          .toList()
                          .map<DropdownMenuEntry<ActivityType>>(
                        (ActivityType filter) {
                          return DropdownMenuEntry<ActivityType>(
                            value: filter,
                            label: filter.capitalizedName,
                            leadingIcon: Icon(filter.icon),
                            style: MenuItemButton.styleFrom(
                              foregroundColor: filter != _selectedType
                                  ? Colors.grey.shade700
                                  : Colors.orange.shade700,
                              iconColor: filter != _selectedType
                                  ? Colors.grey.shade700
                                  : Colors.orange.shade700,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),

                  const Flexible(child: SizedBox(height: 56.0)),
                  Flexible(
                    child: AutoSizeText(
                      'Price range',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.orange.shade700,
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Flexible(child: SizedBox(height: 8.0)),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            'Cheap',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: Colors.grey.shade700),
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            'Expensive',
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Price slider
                  Flexible(
                    child: Slider(
                      activeColor: Colors.orange.shade700,
                      inactiveColor: Colors.grey,
                      value: _selectedPrice,
                      onChanged: (double value) {
                        setState(() {
                          _selectedPrice = value;
                        });
                      },
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                    ),
                  ),
                  const Flexible(child: SizedBox(height: 56.0)),

                  /// Number of Participants Input
                  Flexible(
                    child: AutoSizeText(
                      'Number of Participants',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      '(0 - for any)',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.grey.shade700),
                    ),
                  ),
                  const Flexible(child: SizedBox(height: 16.0)),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 32.0),
                            child: ClipOval(
                              clipBehavior: Clip.hardEdge,
                              child: ColoredBox(
                                color: Colors.orange.shade700,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_selectedParticipants > 0) {
                                        _selectedParticipants--;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: AutoSizeText(
                            _selectedParticipants.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.orange.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: ClipOval(
                              clipBehavior: Clip.hardEdge,
                              child: ColoredBox(
                                color: Colors.orange.shade700,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedParticipants++;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Apply Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: Colors.orange.shade700,
        ),
        child: TextButton(
          onPressed: () {
            debugPrint(
                'Filter to apply: $_selectedType, $_selectedPrice, $_selectedParticipants');

            final filterToApply = Filter(
              type: _selectedType,
              price: _selectedPrice,
              participants: _selectedParticipants,
            );
            context.read<FilterCubit>().applyFilter(filter: filterToApply);
          },
          child: AutoSizeText(
            'Apply Filters',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
