import 'package:quiz_app/features/users/domain/entities/user_entity.dart';
import 'package:quiz_app/features/users/domain/repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository repository;
  GetUsersUsecase({required this.repository});
  Future<List<UserEntity>> call() async {
    return await repository.getUsers();
  }
}
