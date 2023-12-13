// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      key: json['key'] as String?,
      name: json['activity'] as String?,
      type: json['type'] as String?,
      participants: json['participants'] as int?,
      accessibility: (json['accessibility'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'key': instance.key,
      'activity': instance.name,
      'type': instance.type,
      'participants': instance.participants,
      'accessibility': instance.accessibility,
      'price': instance.price,
      'link': instance.link,
    };
