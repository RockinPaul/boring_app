import 'package:boring_app/presentation/components/extra_info_item.dart';
import 'package:flutter/material.dart';
import '../../domain/models/activity.dart';

class DetailsScreen extends StatelessWidget {
  final Activity activity;

  const DetailsScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.orange.shade700,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 4,
              (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/${activity.type}.jpg',
                          fit: BoxFit.cover,
                          height: 300.0,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          height: 300.0,
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                activity.name ?? 'Unknown activity',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.pin_drop),
                                  Text(
                                    'High Toch Campus 64, 5556 AE Eindhoven',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  case 1:
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black54),
                      ),
                    );
                  case 2:
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Text(
                        'Extra Information',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  case 3:
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ExtraInfoItem(
                                  title: 'Price',
                                  activity: activity,
                                ),
                                const SizedBox(height: 8.0),
                                ExtraInfoItem(
                                  title: 'Accessibility',
                                  activity: activity,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              children: [
                                ExtraInfoItem(
                                  title: 'Participants',
                                  activity: activity,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
