import 'package:flutter/material.dart';

class RoundedPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 0; // Adjust this value as needed.
  @override
  double get maxExtent => 100.0; // Adjust this value as needed.

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipPath(
      clipBehavior: Clip.antiAlias,
      clipper: RoundedHeaderClipper(),
      child: Container(
        color: Colors.orange, // Background color of the header
        child: const Center(
          child: Text(
            'Rounded Header',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false; // Set to true if the header should be rebuilt when parameters change.
  }
}

class RoundedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // path.lineTo(0, size.height);
    // path.quadraticBezierTo(
    //     0,size.height - 30,0, size.height - 30);
    path.arcToPoint(Offset(size.width, - size.height / 3), radius: const Radius.circular(120.0), clockwise: false);
    // path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Set to true if you want to recreate the path when parameters change.
  }
}