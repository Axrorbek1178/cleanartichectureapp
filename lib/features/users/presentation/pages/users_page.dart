import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/di/injection.dart'; // DI import
import 'package:quiz_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:shimmer/shimmer.dart';
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
              return ListView.builder(
                itemCount: 8, // Ekranga soxta 8 ta element chiqaramiz
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListTile(
                      // Rasm uchun soxta joy
                      leading: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8), // biroz yumaloqlik
                        ),
                      ),
                      // Title uchun soxta joy
                      title: Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 8),
                      ),
                      // Subtitle uchun soxta joy
                      subtitle: Container(
                        width: 150,
                        height: 14,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              );
            } 
             else if (state is UserLoaded) {
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