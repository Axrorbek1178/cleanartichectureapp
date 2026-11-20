import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:quiz_app/features/users/data/repositories_impl/user_repository_impl.dart';
import 'package:quiz_app/features/users/domain/repositories/user_repository.dart';
import 'package:quiz_app/features/users/domain/usecases/get_users_usecase.dart';


final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com')),
  );

  // 2. DataSource'lar (User)
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // 3. Repository'lar (User)
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl<UserRemoteDataSource>()),
  );

  // 4. UseCase'lar (User)
  sl.registerLazySingleton<GetUsersUsecase>(
    () => GetUsersUsecase(repository: sl<UserRepository>()),
  );

  // ==========================================
  // 2. DataSource'lar (Post)
 

  // // 3. Repository'lar (Post)
  // sl.registerLazySingleton<PostRepository>(
  //   () => PostRepositoryImpl(remoteDataSource: sl<PostRemoteDataSource>()),
  // );

  // // 4. UseCase'lar (Post)
  // sl.registerLazySingleton<GetPostsUsecase>(
  //   () => GetPostsUsecase(repository: sl<PostRepository>()),
  // );
}