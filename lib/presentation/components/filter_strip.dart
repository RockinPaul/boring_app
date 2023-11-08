import 'package:boring_app/presentation/components/filter_item.dart';
import 'package:flutter/material.dart';

class FilterStrip extends StatelessWidget {
  const FilterStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterItem(type: 'All', isSelected: true),
          FilterItem(type: 'Recreational', isSelected: false),
          FilterItem(type: 'Social', isSelected: false),
          FilterItem(type: 'Cooking', isSelected: false),
          FilterItem(type: 'DIY', isSelected: false),
          FilterItem(type: 'Education', isSelected: false),
          FilterItem(type: 'Charity', isSelected: false),
          FilterItem(type: 'Relaxation', isSelected: false),
          FilterItem(type: 'Music', isSelected: false),
          FilterItem(type: 'Work', isSelected: false),
        ],
      ),
    );
  }
}
