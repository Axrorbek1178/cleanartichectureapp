import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/di/injection.dart'; // DI import
import 'package:quiz_app/features/users/domain/usecases/get_users_usecase.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Bloc'ni DI orqali yaratamiz
      create: (context) => UserBloc(sl<GetUsersUsecase>())..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Foydalanuvchilar")),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user.id.toString())),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(child: Text("Xatolik: ${state.message}"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}