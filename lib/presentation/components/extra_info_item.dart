import 'package:flutter/material.dart';
import '../../data/models/activity.dart';
import 'custom_progress_bar.dart';

class ExtraInfoItem extends StatelessWidget {
  final String title;
  final Activity activity;

  const ExtraInfoItem({super.key, required this.title, required this.activity});

  @override
  Widget build(BuildContext context) {
    final icon = switch (title) {
      'Price' => Icons.euro,
      'Participants' => Icons.person,
      'Accessibility' => Icons.accessibility_new_outlined,
      _ => Icons.euro,
    };

    final value = switch (title) {
      'Price' => activity.price ?? 0.0,
      'Participants' => activity.participants!.toDouble(),
      'Accessibility' => activity.accessibility ?? 0.0,
      _ => 0.0,
    };

    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(icon),
          CustomProgressBar(
            iconData: icon,
            percentage: value,
            fillColor: Colors.yellow.shade600,
            backgroundColor: Colors.grey,
          ),
          const SizedBox(height: 4.0),
          Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
