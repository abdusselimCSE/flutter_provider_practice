import 'package:dio/dio.dart';
import 'package:state_management_provider/core/network_executor/error_mapper/error_mapper.dart';
import 'package:state_management_provider/core/network_executor/models/request_model.dart';

import 'models/network_response.dart';

///Network executor is a class for handling all the network http calls

class NetworkExecutor {
  final Dio dio;
  final ErrorMapper errorMapper;

  NetworkExecutor({required this.dio, required this.errorMapper});

  Future<NetworkResponse> getRequest(RequestModel requestModel) async {
    try {
      final Response response = await dio.get(
        requestModel.path,
        queryParameters: requestModel.queryParams,
        options: Options(headers: requestModel.headers),
      );

      return NetworkResponse(
        statusCode: response.statusCode ?? -1,
        data: response.data,
      );
    } catch (e) {
      return errorMapper.mapError(e as Exception);
    }
  }

  Future<NetworkResponse> postRequest(RequestModel requestModel) async {
    try {
      final Response response = await dio.post(
        requestModel.path,
        queryParameters: requestModel.queryParams,
        options: Options(headers: requestModel.headers),
        data: requestModel.formData,
      );

      return NetworkResponse(
        statusCode: response.statusCode ?? -1,
        data: response.data,
      );
    } catch (e) {
      return errorMapper.mapError(e as Exception);
    }
  }
}
