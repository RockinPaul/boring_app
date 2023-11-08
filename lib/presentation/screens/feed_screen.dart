// import 'package:boring_app/presentation/components/filter_strip.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../blocs/activity/activity_cubit.dart';
// import '../components/feed_item.dart';
//
// const _maxHeaderHeight = 210.0;
// const _minHeaderHeight = 56.0;
// const _bodyContentRatioMin = .8;
// const _bodyContentRatioMax = 1.0;
// // Must be between min and max values of body content ratio.
// const _bodyContentRatioParallax = .9;
//
// class FeedScreen extends StatefulWidget {
//   const FeedScreen({super.key});
//
//   @override
//   State<FeedScreen> createState() => _FeedScreenState();
// }
//
// class _FeedScreenState extends State<FeedScreen>
//     with SingleTickerProviderStateMixin {
//   final ValueNotifier<double> headerNegativeOffset = ValueNotifier<double>(0);
//   final ValueNotifier<bool> appbarShadow = ValueNotifier<bool>(false);
//
//   @override
//   void dispose() {
//     headerNegativeOffset.dispose();
//     appbarShadow.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(0.0),
//         child: AppBar(
//           backgroundColor: Colors.orange,
//           elevation: 0.0,
//         ),
//       ),
//       body: Stack(
//         children: [
//           ValueListenableBuilder<double>(
//               valueListenable: headerNegativeOffset,
//               builder: (context, offset, child) {
//                 return Transform.translate(
//                   offset: Offset(0, offset * -1),
//                   child: Container(
//                     height: _maxHeaderHeight,
//                     padding: const EdgeInsets.only(
//                       top: 30.0,
//                       bottom: 30.0,
//                     ),
//                     decoration: const BoxDecoration(
//                       color: Colors.orange,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(30.0),
//                         bottomRight: Radius.circular(30.0),
//                       ),
//                     ),
//                     child: const FilterStrip(),
//                   ),
//                 );
//               }),
//           NotificationListener<DraggableScrollableNotification>(
//             onNotification: (notification) {
//               if (notification.extent == _bodyContentRatioMin) {
//                 appbarShadow.value = false;
//                 headerNegativeOffset.value = 0;
//               } else if (notification.extent == _bodyContentRatioMax) {
//                 appbarShadow.value = true;
//                 headerNegativeOffset.value =
//                     _maxHeaderHeight - _minHeaderHeight;
//               } else {
//                 double newValue = (_maxHeaderHeight - _minHeaderHeight) -
//                     ((_maxHeaderHeight - _minHeaderHeight) *
//                         ((_bodyContentRatioParallax - (notification.extent)) /
//                             (_bodyContentRatioMax -
//                                 _bodyContentRatioParallax)));
//                 appbarShadow.value = false;
//                 if (newValue >= _maxHeaderHeight - _minHeaderHeight) {
//                   appbarShadow.value = true;
//                   newValue = _maxHeaderHeight - _minHeaderHeight;
//                 } else if (newValue < 0) {
//                   appbarShadow.value = false;
//                   newValue = 0;
//                 }
//                 headerNegativeOffset.value = newValue;
//               }
//               return true;
//             },
//             child: Stack(
//               children: <Widget>[
//                 DraggableScrollableSheet(
//                   initialChildSize: _bodyContentRatioMin,
//                   minChildSize: _bodyContentRatioMin,
//                   maxChildSize: _bodyContentRatioMax,
//                   builder: (
//                     BuildContext context,
//                     ScrollController scrollController,
//                   ) {
//                     return Stack(
//                       children: <Widget>[
//                         Container(
//                           alignment: AlignmentDirectional.center,
//                           padding: const EdgeInsets.only(
//                             left: 18.0,
//                             right: 18.0,
//                             top: 32.0,
//                           ),
//                           child: BlocConsumer<ActivityCubit, ActivityState>(
//                             listener: (context, state) {
//                               debugPrint('State in listener: $state');
//                             },
//                             buildWhen: (previousState, currentState) {
//                               // To avoid fullscreen loading indicator when adding activities
//                               // to already existing feed.
//                               return !(previousState is ActivityLoadSuccess &&
//                                   currentState is ActivityLoadInProgress);
//                             },
//                             builder: (context, state) {
//                               if (state is ActivityLoadSuccess) {
//                                 final activities = state.activities;
//                                 return ListView.separated(
//                                   controller: scrollController,
//                                   itemCount: activities.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     debugPrint('State in builder: $state');
//                                     final activity = activities[index];
//                                     if (index == activities.length - 1) {
//                                       // When the user reaches the end of the list, fetch the next page.
//                                       BlocProvider.of<ActivityCubit>(context)
//                                           .fetchMore();
//                                     }
//                                     return FeedItem(
//                                       key: ValueKey(activity.key),
//                                       activity: activity,
//                                     );
//                                   },
//                                   separatorBuilder: (_, __) {
//                                     return const SizedBox(height: 20.0);
//                                   },
//                                 );
//                               } else {
//                                 return const Center(
//                                   child: CircularProgressIndicator(
//                                     color: Colors.orange,
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             left: 0.0,
//             right: 0.0,
//             top: 0.0,
//             child: ValueListenableBuilder<bool>(
//                 valueListenable: appbarShadow,
//                 builder: (context, value, child) {
//                   // Default height of appbar is 56.0. We can also
//                   // use a custom widget and height if needed.
//                   return AppBar(
//                     backgroundColor: Colors.orange,
//                     title: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Local activities",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleMedium
//                                   ?.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                             ),
//                             Text(
//                               "What To Do?",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineMedium
//                                   ?.copyWith(
//                                     fontWeight: FontWeight.w800,
//                                     color: Colors.white,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     elevation: value ? 2.0 : 0.0,
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
