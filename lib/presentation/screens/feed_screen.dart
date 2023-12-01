import 'package:boring_app/blocs/filter/filter_cubit.dart';
import 'package:boring_app/presentation/components/filter_strip.dart';
import 'package:boring_app/presentation/components/shimmer.dart';
import 'package:boring_app/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/activity/activity_cubit.dart';
import '../../data/models/activity.dart';
import '../../data/models/filter.dart';
import '../components/all_filters_button.dart';
import '../components/feed_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var _activities = <Activity>[];

  /// _isLoading flag to avoid extra requests on scroll.
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialFilter = Filter(type: ActivityType.all);
      context.read<FilterCubit>().applyFilter(filter: initialFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade700,
      body: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (context, state) {
          debugPrint('State in listener: $state');
          if (state is ActivitySelectSuccess) {
            final activityToShow = state.selectedActivity;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetailsScreen(activity: activityToShow),
              ),
            );
          }
        },
        buildWhen: (previousState, currentState) {
          // debugPrint('Activity previousState: $previousState');
          // debugPrint('Activity currentState: $currentState');

          // To avoid fullscreen loading indicator when adding activities
          // to already existing feed. Also, to avoid unnecessary rebuilds in general.
          if (currentState is ActivityLoadInProgress) {
            return currentState.page == 0;
          } else {
            _isLoading = false;
          }

          return !(previousState is ActivityLoadSuccess &&
                  currentState is ActivityLoadInProgress) &&
              currentState is! ActivitySelectInProgress &&
              currentState is! ActivitySelectSuccess &&
              currentState is! ActivitySelectFailure;
        },
        builder: (context, state) {
          return NestedScrollView(
            // Setting floatHeaderSlivers to true is required in order to float
            // the outer slivers over the inner scroll
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    backgroundColor: Colors.orange.shade700,
                    floating: true,
                    expandedHeight: 210.0,
                    elevation: 0.0,
                    bottom: const PreferredSize(
                      preferredSize: Size.fromHeight(0.0),
                      child: SizedBox.shrink(),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      expandedTitleScale: 1.0,
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 56,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "Local activities",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "What To Do?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Flexible(child: FilterStrip()),
                          const Flexible(
                            child: AllFiltersButton(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ColoredBox(
              color: state is ActivityLoadInProgress ? Colors.white : Colors.orange.shade700,
              child: Builder(
                builder: (context) {
                  return CustomScrollView(
                    key: const PageStorageKey<String>('feed_key'),
                    slivers: [
                      SliverOverlapInjector(
                        // This is the flip side of the SliverOverlapAbsorber
                        // above.
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      if (state is ActivityLoadSuccess)
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            _activities = state.activities;

                            if (index == _activities.length - 1 &&
                                !_isLoading) {
                              // When the user reaches the end of the list, fetch the next page.
                              _isLoading = true;
                              context.read<ActivityCubit>().fetchActivities();
                            }

                            if (index == 0) {
                              return ColoredBox(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: -10,
                                      left: 0,
                                      right: 0,
                                      child: ColoredBox(
                                        color: Colors.white,
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.orange.shade700,
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FeedItem(activity: _activities[index]),
                                  ],
                                ),
                              );
                            } else if (index > _activities.length - 1) {
                              return const Shimmer(
                                linearGradient: shimmerGradient,
                                child: SizedBox(
                                  height: 230,
                                  child: ShimmerLoading(
                                    isLoading: true,
                                    child: FeedShimmerItem(),
                                  ),
                                ),
                              );
                            } else {
                              return ColoredBox(
                                color: Colors.white,
                                child: FeedItem(activity: _activities[index]),
                              );
                            }
                          }),
                        ),
                      if (state is ActivityLoadInProgress)
                        const SliverFillRemaining(
                          hasScrollBody: false,
                          child: FeedProgressIndicator(),
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class FeedProgressIndicator extends StatelessWidget {
  const FeedProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.orange.shade700,
      ),
    );
  }
}
