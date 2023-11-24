import 'package:boring_app/extensions.dart';
import 'package:boring_app/presentation/components/custom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/activity/activity_cubit.dart';
import '../../data/models/activity.dart';

class FeedItem extends StatelessWidget {
  final Activity activity;

  const FeedItem({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () => context.read<ActivityCubit>().showDetails(activity: activity),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 1.0,
              color: Colors.grey.withOpacity(
                0.5,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  'assets/images/${activity.type}.jpg',
                  fit: BoxFit.fitWidth,
                  height: 130,
                  width: double.infinity,
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
                            activity.type?.capitalizeActivityType() ?? 'Unknown activity type',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.orange.shade700,
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
                          CustomProgressBar(
                              iconData: Icons.euro,
                              percentage: activity.price ?? 0.0),
                          const SizedBox(height: 3.0),
                          Text(
                            activity.price!.round() == 0
                                ? 'Free!'
                                : '${activity.price!.round() * 10}/10',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.orange.shade700,
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
      ),
    );
  }
}

class FeedShimmerItem extends StatelessWidget {
  const FeedShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey.withOpacity(
              0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                height: 130,
                color: Colors.grey[300], // Shimmer base color
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
                        Container(
                          height: 16,
                          color: Colors.grey[300], // Shimmer base color
                        ),
                        const SizedBox(height: 3.0),
                        Container(
                          height: 16,
                          color: Colors.grey[300], // Shimmer base color
                        ),
                        const SizedBox(height: 3.0),
                        Container(
                          height: 16,
                          color: Colors.grey[300], // Shimmer base color
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 16,
                          color: Colors.grey[300], // Shimmer base color
                        ),
                        const SizedBox(height: 3.0),
                        Container(
                          width: 40,
                          height: 16,
                          color: Colors.grey[300], // Shimmer base color
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

