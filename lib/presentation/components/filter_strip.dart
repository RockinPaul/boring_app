import 'package:boring_app/presentation/components/filter_item.dart';
import 'package:flutter/material.dart';

class FilterStrip extends StatelessWidget {
  const FilterStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
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
