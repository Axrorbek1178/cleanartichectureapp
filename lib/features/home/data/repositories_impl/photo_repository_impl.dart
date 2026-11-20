import 'package:quiz_app/features/home/data/datasources/user_remote_data_source.dart';
import 'package:quiz_app/features/home/domain/entities/photo_entity.dart';
import 'package:quiz_app/features/home/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource photoRemoteDataSource;
  PhotoRepositoryImpl({required this.photoRemoteDataSource});

  @override
  Future<List<PhotoEntity>> getPhotos() async {
    // Model (DataSource'dan) -> Entity (Domain uchun)
    final models = await photoRemoteDataSource.getPhotos();
    final List<PhotoEntity> entities = models.map((model) => model as PhotoEntity).toList();
    return entities;
  }
}
