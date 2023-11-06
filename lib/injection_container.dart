import 'package:boring_app/data/api_service.dart';
import 'package:boring_app/data/local_storage_service.dart';
import 'package:boring_app/repositories/activity_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://www.boredapi.com/api';
// Service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => ActivityRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ApiService>(
    () => ApiService(
      baseUrl: baseUrl,
      client: sl(),
    ),
  );
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(),
  );
  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}
