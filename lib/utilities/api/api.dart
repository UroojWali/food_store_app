import 'package:dio/dio.dart';
import 'package:food_store/config.dart';

class Api {
  final Dio dio = Dio();

  Api() {
    dio.options.baseUrl = '${Config.apiURL}/api';
  }
}
