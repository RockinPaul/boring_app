import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String type;
  final bool isSelected;

  const FilterItem({
    super.key,
    required this.type,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 3.0,
          color: Colors.white,
        ),
        color: isSelected ? Colors.white : Colors.orange,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: isSelected ? Colors.orange : Colors.white,
          ),
          Text(
            type,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isSelected ? Colors.orange : Colors.white,
                ),
          )
        ],
      ),
    );
  }
}
