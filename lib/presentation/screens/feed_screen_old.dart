import 'package:boring_app/presentation/components/filter_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/activity/activity_cubit.dart';
import '../../data/models/activity.dart';
import '../components/feed_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var _activities = <Activity>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (context, state) {
          debugPrint('State in listener: $state');
        },
        buildWhen: (previousState, currentState) {
          // To avoid fullscreen loading indicator when adding activities
          // to already existing feed.
          return !(previousState is ActivityLoadSuccess &&
              currentState is ActivityLoadInProgress);
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
                    backgroundColor: Colors.orange,
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
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 46.0,
                                right: 46.0,
                                top: 16.0,
                                bottom: 10.0,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Colors.white,
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  debugPrint('Received click');
                                },
                                child: Text(
                                  'Show all filters',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Builder(
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
                          final activity = _activities[index];
                          if (index == _activities.length - 1) {
                            // When the user reaches the end of the list, fetch the next page.
                            BlocProvider.of<ActivityCubit>(context).fetchMore();
                          } else if (index == 0) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: -10,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                FeedItem(activity: activity),
                              ],
                            );
                          } else {
                            return FeedItem(activity: activity);
                          }
                        }),
                      ),
                    if (state is ActivityLoadInProgress)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
