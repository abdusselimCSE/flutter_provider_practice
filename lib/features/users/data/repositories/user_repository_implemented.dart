import 'package:dartz/dartz.dart';
import 'package:state_management_provider/features/common/domain/entities/api_error.dart';
import 'package:state_management_provider/features/users/data/data_sources/user_data_source.dart';
import 'package:state_management_provider/features/users/domain/entities/user.dart';
import 'package:state_management_provider/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);

  @override
  Future<Either<ApiErros, List<User>>> fetchUsers() async {
    final response = await userDataSource.getUsers();

    return response.fold(
      (apiError) {
        return Left(apiError);
      },
      (userModels) {
        final List<User> userList = userModels
            .map((e) => e.toEntity())
            .toList();
        return Right(userList);
      },
    );
  }
}
