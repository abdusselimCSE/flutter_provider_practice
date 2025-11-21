import 'package:dartz/dartz.dart';
import 'package:state_management_provider/features/common/domain/entities/api_error.dart';
import 'package:state_management_provider/features/users/data/models/user_model.dart';

abstract class UserDataSource {
  Future<Either<ApiErros, List<UserModel>>> getUsers();
}
