import 'package:boring_app/presentation/components/price_indicator.dart';
import 'package:flutter/material.dart';

import '../../data/models/activity.dart';

class FeedItem extends StatelessWidget {
  final Activity activity;

  const FeedItem({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(15.0),
      borderOnForeground: false,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/images/${activity.type}.jpg',
                fit: BoxFit.fitWidth,
                height: 130,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.type ?? 'Unknown activity type',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 3.0),
                        Opacity(
                          opacity: 0.6,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 16.0,
                              ),
                              Text(
                                '${activity.participants} | accessibility: ${activity.accessibility!.round() * 10}/10',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          activity.name ?? 'Description unavailable',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PriceIndicator(price: activity.price ?? 0.0),
                        const SizedBox(height: 3.0),
                        Text(
                          activity.price!.round() == 0
                              ? 'Free!'
                              : '${activity.price!.round() * 10}/10',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
