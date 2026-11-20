import 'package:quiz_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:quiz_app/features/users/domain/entities/user_entity.dart';
import 'package:quiz_app/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<UserEntity>> getUsers() async {
    final models = await remoteDataSource.getUsers();
    return models;
  }
}
