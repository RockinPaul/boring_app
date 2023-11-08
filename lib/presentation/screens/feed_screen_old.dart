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
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        backgroundColor: Colors.transparent,
                        floating: true,
                        snap: true,
                        expandedHeight: 200.0,
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        // Position of shadow
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            // Add other header content and the "Show All Filters" button.
                          ),
                        ),
                      )),
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
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              _activities = state.activities;
                              final activity = _activities[index];
                              if (index == _activities.length - 1) {
                                // When the user reaches the end of the list, fetch the next page.
                                BlocProvider.of<ActivityCubit>(context).fetchMore();
                              } else {
                                return FeedItem(activity: activity);
                              }
                            }),
                          ),
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
                }
              ));
        },
      ),
    );
  }
}
