import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:quiz_app/features/home/data/datasources/user_remote_data_source.dart';
import 'package:shimmer/shimmer.dart';
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
              // Diqqat: faylingizda PhotoRemoteDataSourceImpl deb nomlangan bo'lishi kerak
              photoRemoteDataSource: PhotoRemoteDataSourceImpl(dio: Dio()),
            ),
          ),
        )..add(FetchPhotosEvent()),
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            
            // ==========================================
            // 1. API YUKLANAYOTGANDA (BUTUN EKRAN SHIMMER)
            // ==========================================
            if (state is PhotoLoading) {
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
            
            // ==========================================
            // 2. API YUKLANDI (HAQIQIY MA'LUMOTLAR)
            // ==========================================
            else if (state is PhotoLoaded) {
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
                      // Rasmlar yuklanayotganda ham shimmer ko'rsatamiz
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          ),
                        );
                      },
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
            } 
            
            // ==========================================
            // 3. XATOLIK YUZ BERGANDA
            // ==========================================
            else if (state is PhotoError) {
              return Center(child: Text("Xatolik: ${state.message}"));
            }
            
            return const Center(child: Text("Kuting..."));
          },
        ),
      ),
    );
  }
}