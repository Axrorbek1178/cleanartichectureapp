import 'package:dio/dio.dart';
import 'package:quiz_app/features/users/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await dio.get('/users');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception(
        'Foydalanuvchilarni olishda xatolik: ${response.statusCode}',
      );
    }
  }
}
