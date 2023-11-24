import 'package:boring_app/presentation/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/activity/activity_cubit.dart';
import 'blocs/filter/filter_cubit.dart';
import 'injection_container.dart' as injection_container;

Future<void> main() async {
  // Ensure Flutter engine is ready to render results of activities request.
  WidgetsFlutterBinding.ensureInitialized();

  /// Service locator initialization for some loose coupling.
  await injection_container.init();

  /// Initialization of ActivityCubit with repository, resolved by service locator.
  final activityCubit = ActivityCubit(repository: injection_container.sl());
  final filterCubit = FilterCubit(repository: injection_container.sl());

  runApp(
    MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<ActivityCubit>(
          create: (context) => activityCubit,
        ),
        BlocProvider<FilterCubit>(
          create: (context) => filterCubit,
        ),
      ],
      child: const BoringApp(),
    ),
  );
}

class BoringApp extends StatelessWidget {
  const BoringApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Launch activities feed retrieving.
    BlocProvider.of<ActivityCubit>(context).fetchActivities();

    return MaterialApp(
      title: 'Boring application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FeedScreen(),
    );
  }
}
