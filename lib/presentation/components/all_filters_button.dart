import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class AllFiltersButton extends StatelessWidget {
  const AllFiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 46.0,
        right: 46.0,
        top: 16.0,
        bottom: 10.0,
      ),
      width: double.infinity,
      height: 40.0,
      decoration: const BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: () => _showAllFilters(context),
        child: Text(
          'Show all filters',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(
            color: Colors.orange.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showAllFilters(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const FiltersScreen()
    ));
  }
}
