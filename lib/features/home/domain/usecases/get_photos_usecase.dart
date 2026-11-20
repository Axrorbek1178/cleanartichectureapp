import 'package:quiz_app/features/home/domain/entities/photo_entity.dart';
import 'package:quiz_app/features/home/domain/repositories/photo_repository.dart';

class GetPhotosUsecase {
  final PhotoRepository repository;
  GetPhotosUsecase(this.repository);

  Future<List<PhotoEntity>> call() async {
    return await repository.getPhotos();
  }
}
