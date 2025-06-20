import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import '../errors/exceptions.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.baseUrl}$path',
      ).replace(queryParameters: queryParams);

      final response = await client
          .get(uri)
          .timeout(const Duration(milliseconds: ApiConstants.receiveTimeout));

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 404:
        throw ServerException('Resource not found');
      case 500:
      default:
        throw ServerException(
          'Error occurred with status code: ${response.statusCode}',
        );
    }
  }
}
