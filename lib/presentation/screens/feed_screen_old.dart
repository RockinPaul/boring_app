import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/activity/activity_cubit.dart';
import '../components/feed_item.dart';
import '../components/rounded_persistent_header_delegate.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return BlocConsumer<ActivityCubit, ActivityState>(
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
                    debugPrint('State in builder: $state');
                    if (state is ActivityLoadSuccess) {
                      final activities = state.activities;
                      final activity = activities[index];
                      if (index == activities.length - 1) {
                        // When the user reaches the end of the list, fetch the next page.
                        BlocProvider.of<ActivityCubit>(context).fetchMore();
                      }
                      return FeedItem(activity: activity);
                    } else if (state is ActivityLoadInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container(color: Colors.indigo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
