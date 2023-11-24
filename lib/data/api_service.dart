import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:boring_app/data/models/activity.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({
    required this.baseUrl,
    required this.client,
  });

  Future<List<Activity>> fetchRandomActivities(
    int numberOfEvents, {
    String? type,
    int? participants,
    double? price,
  }) async {
    final List<Activity> events = [];
    final List<String> filters = [];

    final plainActivityUrl = '$baseUrl/activity';

    if (type != null) filters.add('?type=$type');
    if (participants != null) filters.add('?participants=$participants');
    if (price != null) filters.add('?price=$price');

    final queryString = filters.join('&');
    final url = '$plainActivityUrl$queryString';

    for (int i = 0; i < numberOfEvents; i++) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // final data = json.decode(response.body);
        final activity = activityFromJson(response.body);
        events.add(activity);
      } else {
        // Handle the error if the request fails
        debugPrint('Failed to fetch random event: ${response.statusCode}');
      }
    }

    if (events.isNotEmpty) {
      for (final activity in events) {
        debugPrint('Activity: ${activity.name}');
        debugPrint('Type: ${activity.type}');
        debugPrint('Participants: ${activity.participants}');
        debugPrint('-----------------------');
      }
    } else {
      debugPrint(
          'Failed to fetch any random activities, or no activities were found.');
    }
    return events;
  }
}
