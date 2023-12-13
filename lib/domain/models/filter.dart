
import 'package:boring_app/utils/extensions.dart';
import 'package:flutter/material.dart';

enum ActivityType {
  all('all', Icons.search),
  recreational('recreational', Icons.golf_course),
  educational('education', Icons.library_books),
  social('social', Icons.people),
  music('music', Icons.music_note),
  busywork('busywork', Icons.work),
  diy('diy', Icons.handyman),
  charity('charity', Icons.handshake),
  cooking('cooking', Icons.cake),
  relaxation('relaxation', Icons.flight_takeoff);

  const ActivityType(this.name, this.icon);

  final String name;
  final IconData icon;

  String get capitalizedName => name.capitalizeActivityType();
}

class Filter {
  final ActivityType? type;
  final double? price;
  final int? participants;

  Filter({
    this.type,
    this.price,
    this.participants,
  });
}
