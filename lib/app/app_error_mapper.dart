import 'package:state_management_provider/core/network_executor/error_mapper/error_mapper.dart';
import 'package:state_management_provider/core/network_executor/models/network_response.dart';

class AppErrorMapper implements ErrorMapper {
  @override
  NetworkResponse mapError(Exception e) {
    // TODO: implement mapError
    throw UnimplementedError();
  }
}
