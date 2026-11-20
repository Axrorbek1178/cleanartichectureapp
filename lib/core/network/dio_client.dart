import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;
  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.sizning-sayt.com',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    // Interceptor: Har bir so'rovga tokenni avtomatik qo'shish
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // final token = ShredPref.getToken(); // Tokkeni oling
          // options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Xatoliklarni markazlashgan holda ushlash  mantiqini yozamiz(masalan, 401 bo'lsa, logout qilish)
          if (e.response?.statusCode == 401) {

          }
          return handler.next(e);
        },
      ),
    );
  }
}
