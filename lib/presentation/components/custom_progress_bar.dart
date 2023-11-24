import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final IconData iconData;
  final double percentage;
  final Color fillColor;
  final Color backgroundColor;

  const CustomProgressBar({super.key,
    required this.iconData,
    required this.percentage,
    this.fillColor = Colors.blue,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background icon
        Icon(
          iconData,
          size: 35.0,
          color: backgroundColor,
        ),
        // Foreground icon with custom color based on percentage
        Positioned(
          top: 0,
          left: 0,
          child: ClipRect(
            clipper: _IconClipper(percentage),
            child: Icon(
              iconData,
              size: 50.0, // Set the size of your icon
              color: fillColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _IconClipper extends CustomClipper<Rect> {
  final double percentage;

  _IconClipper(this.percentage);

  @override
  Rect getClip(Size size) {
    // Calculate the width based on the percentage
    double width = size.width * (percentage / 100.0);

    // Return the rectangular clip area
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
