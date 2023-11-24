import 'package:auto_size_text/auto_size_text.dart';
import 'package:boring_app/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/filter/filter_cubit.dart';
import '../components/filter_item.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String selectedType = 'all';
  double selectedPrice = 0.5;
  int selectedParticipants = 1;

  final TextEditingController participantsController =
      TextEditingController(text: '1');

  // final TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.orange.shade700,
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          if (state is FilterApplySuccess) {
            // Handle success state if needed
          } else if (state is FilterApplyFailure) {
            // Handle failure state if needed
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
                  // Type (Category) Dropdown

                  Flexible(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.orange.shade700,
                      value: selectedType,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedType = newValue!;
                        });
                      },
                      items: [
                        'all',
                        'recreational',
                        'educational',
                        'social',
                        'music',
                        'busywork',
                        'diy',
                        'charity',
                        'cooking',
                        'relaxation',
                      ]
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: AutoSizeText(
                                value.capitalizeActivityType(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          )
                          .toList(),
                      hint: const AutoSizeText('Select Type'),
                    ),
                  ),

                  Flexible(
                    child: DropdownMenu<ActivityType>(
                      // controller: filterController,
                      enableFilter: false,
                      requestFocusOnTap: false,
                      leadingIcon: const Icon(Icons.search),
                      label: const Text('Icon'),
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      initialSelection: ActivityType.recreational,
                      onSelected: (ActivityType? activityType) {
                        if (activityType != null) {
                          context.read<FilterCubit>().updateType(activityType);
                        }
                      },
                      dropdownMenuEntries: ActivityType.values
                          .map<DropdownMenuEntry<ActivityType>>(
                        (ActivityType filter) {
                          return DropdownMenuEntry<ActivityType>(
                            value: filter,
                            label: filter.capitalizedName,
                            leadingIcon: Icon(filter.icon),
                          );
                        },
                      ).toList(),
                    ),
                  ),

                  const Flexible(child: SizedBox(height: 56.0)),
                  Flexible(
                    child: AutoSizeText(
                      'Price range',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
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
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            'Expensive',
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Price Slider
                  Flexible(
                    child: Slider(
                      activeColor: Colors.orange.shade700,
                      inactiveColor: Colors.grey,
                      value: selectedPrice,
                      onChanged: (double value) {
                        setState(() {
                          selectedPrice = value;
                        });
                      },
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                    ),
                  ),
                  const Flexible(child: SizedBox(height: 56.0)),
                  // Number of Participants Input
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
                      style: Theme.of(context).textTheme.labelLarge,
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
                                      if (selectedParticipants > 1) {
                                        selectedParticipants--;
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
                          selectedParticipants.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                        )),
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
                                      selectedParticipants++;
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
        child: OutlinedButton(
          onPressed: () {
            // Dispatch an event to the cubit to apply filters
            context.read<FilterCubit>().applyFilters(
                  selectedType: selectedType,
                  selectedPrice: selectedPrice,
                  selectedParticipants: selectedParticipants,
                );
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
