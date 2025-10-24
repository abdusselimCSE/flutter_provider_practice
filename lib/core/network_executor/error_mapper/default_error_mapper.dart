import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/network_response.dart' show NetworkResponse;
import 'error_mapper.dart';

class DefaultErrorMapper implements ErrorMapper {
  final VoidCallback onUnauthorize;

  DefaultErrorMapper({required this.onUnauthorize});

  @override
  NetworkResponse mapError(Exception e) {
    if (e is DioException) {
      if (e.response?.statusCode == 401) {
        //TODO: Redirect to login screen
        //Lets decide from client end
        onUnauthorize();
        return NetworkResponse(statusCode: 401, data: e.response?.data);
      } else {
        return NetworkResponse(
          statusCode: e.response?.statusCode ?? -1,
          data: e.response?.data,
        );
      }
    } else {
      return NetworkResponse(statusCode: -1, data: "Something went wrong");
    }
  }
}
