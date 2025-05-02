import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

class ApiResponse<T> {
  final T? data;
  final String? errorMessage;
  final int? statusCode;
  final bool isSuccess;

  ApiResponse({this.data, this.errorMessage, this.statusCode, required this.isSuccess});

  factory ApiResponse.success(T data) => ApiResponse(data: data, isSuccess: true);

  factory ApiResponse.error(String errorMessage, {int? statusCode}) =>
      ApiResponse(errorMessage: errorMessage, statusCode: statusCode, isSuccess: false);
}

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio() {
    _dio.options.baseUrl = 'https://fakestoreapi.com/'; // Replace with your API base URL
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};

    _dio.interceptors.add(
        LogInterceptor(request: true, requestHeader: true, requestBody: true, responseHeader: true, responseBody: true, error: true));
  }

  Future<ApiResponse<T>> get<T>({required String path}) async {
    try {
      final response = await _dio.get(path);

      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred: $e');
    }
  }
}

ApiResponse<T> handleDioError<T>(DioException e) {
  String errorMessage;
  int? statusCode;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      errorMessage = 'Connection timeout. Please check your internet connection.';
      break;
    case DioExceptionType.sendTimeout:
      errorMessage = 'Send timeout. Please check your internet connection.';
      break;
    case DioExceptionType.receiveTimeout:
      errorMessage = 'Receive timeout. Please check your internet connection.';
      break;
    case DioExceptionType.badCertificate:
      errorMessage = 'Bad certificate. Please try again later.';
      break;
    case DioExceptionType.badResponse:
      statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        errorMessage = 'Unauthorized. Please login again.';
      } else if (statusCode == 403) {
        errorMessage = 'Forbidden. You do not have permission to access this resource.';
      } else if (statusCode == 404) {
        errorMessage = 'Resource not found.';
      } else if (statusCode == 500) {
        errorMessage = 'Server error. Please try again later.';
      } else {
        errorMessage = e.response?.data?['message'] ?? 'Unknown server error.';
      }
      break;
    case DioExceptionType.cancel:
      errorMessage = 'Request cancelled.';
      break;
    case DioExceptionType.connectionError:
      errorMessage = 'No internet connection.';
      break;
    case DioExceptionType.unknown:
    default:
      errorMessage = 'Something went wrong. Please try again.';
      break;
  }

  return ApiResponse.error(errorMessage, statusCode: statusCode);
}
