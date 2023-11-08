import 'package:boring_app/presentation/screens/feed_screen_old.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/activity/activity_cubit.dart';
import 'injection_container.dart' as injection_container;

Future<void> main() async {
  // Ensure Flutter engine is ready to render results of activities request.
  WidgetsFlutterBinding.ensureInitialized();

  // Service locator initialization for some loose coupling.
  await injection_container.init();

  // Initialization of ActivityCubit with repository, resolved by service locator.
  final activityCubit = ActivityCubit(repository: injection_container.sl());
  runApp(
    BlocProvider(
      create: (context) => activityCubit,
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
    BlocProvider.of<ActivityCubit>(context).appStarted();

    return MaterialApp(
      title: 'Boring application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FeedScreen(),
    );
  }
}
