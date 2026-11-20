import 'package:dio/dio.dart';
import 'package:quiz_app/features/home/data/models/photos_model.dart';

abstract class PhotoRemoteDataSource {
  Future<List<PhotoModel>> getPhotos();
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final Dio dio;

  PhotoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PhotoModel>> getPhotos() async {
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/photos',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PhotoModel.fromJson(json)).toList();
      } else {
        throw Exception('Server xatosi: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Tarmoq xatosi: ${e.message}');
    }
  }
}