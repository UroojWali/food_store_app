import 'package:dio/dio.dart';
import 'package:food_store/utilities/api/api.dart';
import 'package:food_store/utilities/exceptions/authentication_exception.dart';
import 'package:food_store/utilities/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi extends Api {
  // LoginApi() {
  // dio.options.baseUrl = '${Config.apiURL}/api/users/login';
  // }

  /// Login with [email] and [password].
  /// throw [AuthenticationException] if login fails.
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post('/users/login', data: {
        'email': email,
        'password': password,
      });
      final SharedPreferencesWithCache prefsWithCache =
          await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          // When an allowlist is included, any keys that aren't included cannot be used.
          allowList: <String>{'token'},
        ),
      );
      await prefsWithCache.setString('token', response.data['token']);
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.unknown) {
        logger.e('No internet connection');
        throw const AuthenticationException('No internet connection');
      }
      if (e.response!.statusCode == 401) {
        logger.e(e.response?.data['message']);
        throw AuthenticationException(e.response?.data['message']);
      }
      throw const AuthenticationException("Some error occurred");
    } on Exception catch (e) {
      logger.e('Something went wrong$e');
      throw AuthenticationException('Something went wrong$e');
    }
    // return username == 'admin' && password == 'admin';
  }
}
