import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

Activity activityFromJson(dynamic jsonString) =>
    _$ActivityFromJson(jsonDecode(jsonString));

@JsonSerializable()
class Activity {
  @JsonKey(name: 'key')
  final String? key;

  @JsonKey(name: 'activity')
  final String? name;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'participants')
  final int? participants;

  @JsonKey(name: 'accessibility')
  final double? accessibility;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'link')
  final String? link;

  // Amount of likes with like icon will be a randomly generated number.
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
