import 'package:boring_app/presentation/components/filter_item.dart';
import 'package:flutter/material.dart';

import '../../domain/models/filter.dart';

class FilterStrip extends StatelessWidget {
  const FilterStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterItem(type: ActivityType.all),
          FilterItem(type: ActivityType.recreational),
          FilterItem(type: ActivityType.social),
          FilterItem(type: ActivityType.cooking),
          FilterItem(type: ActivityType.diy),
          FilterItem(type: ActivityType.educational),
          FilterItem(type: ActivityType.charity),
          FilterItem(type: ActivityType.relaxation),
          FilterItem(type: ActivityType.music),
          FilterItem(type: ActivityType.busywork),
        ],
      ),
    );
  }
}
