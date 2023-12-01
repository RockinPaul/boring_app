import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final IconData iconData;
  final double progress;
  final Color fillColor;
  final Color backgroundColor;

  const CustomProgressBar({super.key,
    required this.iconData,
    required this.progress,
    this.fillColor = Colors.yellow,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background icon
        Icon(
          iconData,
          size: 45.0,
          color: backgroundColor,
        ),
        // Foreground icon with custom color based on percentage
        ClipRect(
          clipper: _IconClipper(progress),
          child: Icon(
            iconData,
            size: 45.0, // Set the size of your icon
            color: fillColor,
          ),
        ),
      ],
    );
  }
}

class _IconClipper extends CustomClipper<Rect> {
  final double progress;

  _IconClipper(this.progress);

  @override
  Rect getClip(Size size) {
    // Calculate the width based on the percentage
    double width = size.width * progress;

    // Return the rectangular clip area
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
