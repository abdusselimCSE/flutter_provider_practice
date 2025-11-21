import 'package:dartz/dartz.dart';
import 'package:state_management_provider/features/common/domain/entities/api_error.dart';
import 'package:state_management_provider/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<ApiErros, List<User>>> fetchUsers();
}
