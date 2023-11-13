import 'package:auto_size_text/auto_size_text.dart';
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
    var iconData = Icons.search;
    switch (type) {
      case 'Recreational':
        iconData = Icons.golf_course;
      case 'Social':
        iconData = Icons.people;
      case 'Cooking':
        iconData = Icons.cake;
      case 'DIY':
        iconData = Icons.handyman;
      case 'Education':
        iconData = Icons.library_books;
      case 'Charity':
        iconData = Icons.handshake;
      case 'Relaxation':
        iconData = Icons.flight_takeoff;
      case 'Music':
        iconData = Icons.music_note;
      case 'Work':
        iconData = Icons.work;
    }
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
        color: isSelected ? Colors.white : Colors.orange.shade700,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: isSelected ? Colors.orange.shade700 : Colors.white,
          ),
          AutoSizeText(
            type,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isSelected ? Colors.orange.shade700 : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
            wrapWords: false,
            minFontSize: 8.0,
          )
        ],
      ),
    );
  }
}
