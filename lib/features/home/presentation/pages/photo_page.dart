import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:quiz_app/features/home/data/datasources/user_remote_data_source.dart';
import 'package:quiz_app/features/home/data/repositories_impl/photo_repository_impl.dart';
import 'package:quiz_app/features/home/domain/usecases/get_photos_usecase.dart';
import 'package:quiz_app/features/home/presentation/bloc/photo_bloc.dart';
import 'package:quiz_app/features/users/presentation/pages/users_page.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rasmlar")),
      body: BlocProvider(
        create: (context) => PhotoBloc(
          getPhotosUsecase: GetPhotosUsecase(
            PhotoRepositoryImpl(
              photoRemoteDataSource: PhotoRemoteDataSourceImpl(dio: Dio()),
            ),
          ),
        )..add(FetchPhotosEvent()),
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is PhotoLoaded) {
              return ListView.builder(
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return ListTile(
                    leading: Image.network(
                      photo.thumbnailUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
                    ),
                    title: Text(photo.title),
                    subtitle: Text("ID: ${photo.id}"),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsersPage()),
                    ),
                  );
                },
              );
            } else if (state is PhotoError) {
              return Center(child: Text("Xatolik: ${state.message}"));
            }
            return const Center(child: Text("Kuting..."));
          },
        ),
      ),
    );
  }
}
