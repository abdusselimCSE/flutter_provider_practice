import '../models/network_response.dart' show NetworkResponse;

abstract class ErrorMapper {
  NetworkResponse mapError(Exception e);
}
