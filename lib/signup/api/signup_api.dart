import 'package:dio/dio.dart';
import 'package:food_store/utilities/api/api.dart';
import 'package:food_store/utilities/exceptions/authentication_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupApi extends Api {
  /// Signup with [name], [email] and [password].
  /// throw [AuthenticationException] if signup fails.
  Future<Map<String, dynamic>> signup(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post('/users/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['token']);
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.unknown) {
        throw const AuthenticationException('No internet connection');
      }
      if (e.response?.data['message'] != null) {
        throw AuthenticationException(e.response!.data['message']);
      }
      throw const AuthenticationException("Some error occurred");
    } on Exception {
      throw const AuthenticationException('Something went wrong');
    }
  }
}
