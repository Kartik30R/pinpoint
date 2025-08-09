import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pinpoint/data/exceptions/app_exceptions.dart';
import 'package:pinpoint/data/network/base_api_response.dart';

class NetworkApiService implements BaseApiServices {
 @override
Future getGetApiResponse(String url, {Map<String, String>? headers}) async {
  if (kDebugMode) print(url);

  dynamic responseJson;
  try {
    final mergedHeaders = {
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    final response = await http.get(
      Uri.parse(url),
      headers: mergedHeaders,
    ).timeout(const Duration(seconds: 20));

    responseJson = returnResponse(response);
  } on SocketException {
    throw NoInternetException('');
  } on TimeoutException {
    throw FetchDataException('Network Request time out');
  }

  if (kDebugMode) print(responseJson);
  return responseJson;
}


@override
Future getPostApiResponse(String url, dynamic data, {Map<String, String>? headers}) async {

  dynamic responseJson;
  try {
    final mergedHeaders = {
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: mergedHeaders,
      body: jsonEncode(data),
    ).timeout(const Duration(seconds: 10));

    responseJson = returnResponse(response);
  } on SocketException {
    throw NoInternetException('No Internet Connection');
  } on TimeoutException {
    throw FetchDataException('Network Request timed out');
  }

  if (kDebugMode) {
    print("Response → $responseJson");
  }
  return responseJson;
}

@override
Future getDeleteApiResponse(String url, {Map<String, String>? headers}) async {
  dynamic responseJson;
  try {
    final mergedHeaders = {
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    final response = await http.delete(
      Uri.parse(url),
      headers: mergedHeaders,
    ).timeout(const Duration(seconds: 10));

    responseJson = returnResponse(response);
  } on SocketException {
    throw NoInternetException('No Internet Connection');
  } on TimeoutException {
    throw FetchDataException('Network Request timed out');
  }

  if (kDebugMode) print("Response → $responseJson");
  return responseJson;
}



  dynamic returnResponse (http.Response response){
    if (kDebugMode) {
      print(response.statusCode);
    }

    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error occured while communicating with server');

    }
  }

}