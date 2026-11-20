import 'package:bloc/bloc.dart';
import 'package:quiz_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:quiz_app/features/users/presentation/bloc/user_state.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUsecase getUserUseCase;
  UserBloc(this.getUserUseCase,) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final users = getUserUseCase();
        emit(UserLoaded(await users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
