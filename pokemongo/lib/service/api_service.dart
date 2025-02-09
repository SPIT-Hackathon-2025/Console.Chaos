import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(String baseUrl, {Map<String, String>? defaultHeaders})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: defaultHeaders ?? {},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        )) {
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<dynamic> _request(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final options = Options(method: method, headers: headers);
      final Response response;

      if (method == 'GET' || method == 'DELETE') {
        response = await _dio.request(endpoint, options: options, queryParameters: queryParams);
      } else {
        response = await _dio.request(endpoint, data: jsonEncode(body), options: options, queryParameters: queryParams);
      }

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.statusMessage}');
    }
  }

  dynamic _handleError(DioException error) {
    if (error.response != null) {
      throw Exception('API Error ${error.response?.statusCode}: ${error.response?.data}');
    } else {
      throw Exception('Network Error: ${error.message}');
    }
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async =>
      _request(endpoint, headers: headers, queryParams: queryParams);

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers, Map<String, dynamic>? queryParams}) async =>
      _request(endpoint, method: 'POST', body: body, headers: headers, queryParams: queryParams);

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers, Map<String, dynamic>? queryParams}) async =>
      _request(endpoint, method: 'PUT', body: body, headers: headers, queryParams: queryParams);

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async =>
      _request(endpoint, method: 'DELETE', headers: headers, queryParams: queryParams);

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}

/*
usage: 

final apiService = ApiService('https://your-api.com');

final response = await apiService.get('/posts');
print(response);
*/