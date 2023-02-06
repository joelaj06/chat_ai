import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_ai/core/utils/environment.dart';
import 'package:http/http.dart' as http;
import 'package:logger/src/logger.dart';

import '../error/app_exceptions.dart';
import 'app_log.dart';

class AppHTTPClient {
  final Logger appLog = appLogger(AppHTTPClient);
  static const int requestTimeout = 20;

  //GET
  Future<dynamic> get(String baseUrl, String endpoint) async {
    final Uri uri = Uri.parse(
      baseUrl + endpoint,
    );
    appLog.d('============================ ENDPOINT ========================');
    appLog.d(endpoint);
    try {
      final http.Response response = await http.get(uri).timeout(
            const Duration(seconds: requestTimeout),
          );
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Connection problem', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Request Timeout', uri.toString());
    }
  }

  // POST
  Future<Map<String,dynamic>> post(String baseUrl, String endpoint,
      {required Map<String, dynamic> body}) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);
    appLog.d('============================ ENDPOINT ========================');
    appLog.d(endpoint);
    appLog.d('====================== BODY SENT =========================');
    appLog.d(body);
    try {
      final http.Response response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Connection problem', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Request Timeout', uri.toString());
    }
  }

  //PUT
  Future<dynamic> put(String baseUrl, String endpoint, {dynamic body}) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);
    appLog.d('============================ ENDPOINT ========================');
    appLog.d(endpoint);
    appLog.d('====================== BODY SENT =========================');
    appLog.d(body);
    try {
      final http.Response response = await http.put(uri, body: body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Connection problem', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Request Timeout', uri.toString());
    }
  }

  //DELETE

  Future<dynamic> delete(String baseUrl, String endpoint) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);
    appLog.d('============================ ENDPOINT ========================');
    appLog.d(endpoint);
    try {
      final http.Response response = await http.delete(uri);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Connection problem', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Request Timeout', uri.toString());
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseJson =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        appLog.d('============================ BODY RECEIVED ========================');
        appLog.i(response.body);
        //appLog.i(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      case 401:
      case 403:
        throw UnauthorizedException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      case 500:
      default:
        throw FetchDataException(
          'Error occurred with code ${response.statusCode}',
          response.request!.url.toString(),
        );
    }
  }
}
