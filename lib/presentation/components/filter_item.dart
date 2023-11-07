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
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: isSelected ? Colors.white : Colors.orange,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Icon(
              Icons.search,
              color: isSelected ? Colors.orange : Colors.white,
            ),
          ),
          Flexible(
            child: Text(
              type,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? Colors.orange : Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
