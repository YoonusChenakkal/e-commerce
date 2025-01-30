import 'dart:convert';
import 'dart:io';
import 'package:e_commerce/services/app_exceptions.dart';
import 'package:e_commerce/services/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkServices extends BaseApiServices {
  @override
  Future getApi(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApi(String url, body) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: body)
          .timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    print(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseBody;

      case 400:
        String errorMessage = responseBody.values.first[0];
        throw BadRequestException(errorMessage);
      case 401:
        throw UnauthorizedException(
            responseBody['message'] ?? 'Unauthorized request');

      case 404:
        throw NotFoundException('The requested resource was not found');

      case 500:
        throw ServerErrorException(
            responseBody['error'] ?? 'Internal server error');

      default:
        throw FetchDataException(
            'Error occurred while communicating with server. Status code: ${response.statusCode}');
    }
  }
}
