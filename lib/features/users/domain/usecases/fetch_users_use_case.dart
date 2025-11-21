import 'package:dartz/dartz.dart';
import 'package:state_management_provider/features/common/domain/entities/api_error.dart';
import 'package:state_management_provider/features/common/domain/entities/no_params.dart';
import 'package:state_management_provider/features/common/domain/use_cases/use_case.dart';
import 'package:state_management_provider/features/users/domain/entities/user.dart';
import 'package:state_management_provider/features/users/domain/repositories/user_repository.dart';

class FetchUsersUseCase
    implements UseCase<Either<ApiErros, List<User>>, NoParams> {
  final UserRepository userRepository;

  FetchUsersUseCase(this.userRepository);

  @override
  Future<Either<ApiErros, List<User>>> call(NoParams params) async {
    return await userRepository.fetchUsers();
  }
}
