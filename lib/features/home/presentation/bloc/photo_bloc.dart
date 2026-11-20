import 'package:bloc/bloc.dart';
import 'package:quiz_app/features/home/domain/entities/photo_entity.dart';
import 'package:quiz_app/features/home/domain/usecases/get_photos_usecase.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotosUsecase getPhotosUsecase;
  PhotoBloc({required this.getPhotosUsecase}) : super(PhotoInitial()) {
    on<FetchPhotosEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = getPhotosUsecase();
        emit(PhotoLoaded(await photos));
      }
      catch (e) {
        emit(PhotoError( e.toString()));
      }
    });
  }
}
