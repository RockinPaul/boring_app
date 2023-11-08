import 'package:boring_app/presentation/components/filter_item.dart';
import 'package:flutter/material.dart';

class FilterStrip extends StatelessWidget {
  const FilterStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SingleChildScrollView(
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
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 46.0,
            right: 46.0,
          ),
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: OutlinedButton(
            onPressed: () {
              debugPrint('Received click');
            },
            child: Text(
              'Show all filters',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.orange,
                fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
