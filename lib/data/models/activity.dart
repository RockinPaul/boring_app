import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

Activity activityFromJson(dynamic jsonString) =>
    _$ActivityFromJson(jsonDecode(jsonString));

@HiveType(typeId: 0)
@JsonSerializable()
class Activity {
  @HiveField(0)
  @JsonKey(name: 'key')
  final String? key;

  @HiveField(1)
  @JsonKey(name: 'activity')
  final String? name;

  @HiveField(2)
  @JsonKey(name: 'type')
  final String? type;

  @HiveField(3)
  @JsonKey(name: 'participants')
  final int? participants;

  @HiveField(4)
  @JsonKey(name: 'accessibility')
  final double? accessibility;

  @HiveField(5)
  @JsonKey(name: 'price')
  final double? price;


  @HiveField(6)
  @JsonKey(name: 'link')
  final String? link;

  // Amount of likes with like icon will be a randomly generated number.
  @HiveField(7)
  @JsonKey(
    name: 'likes',
    includeFromJson: false,
    includeToJson: false,
    required: false,
  )
  final int? likes;

  Activity({
    required this.key,
    required this.name,
    required this.type,
    required this.participants,
    required this.accessibility,
    required this.price,
    required this.link,
    this.likes,
  });

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
