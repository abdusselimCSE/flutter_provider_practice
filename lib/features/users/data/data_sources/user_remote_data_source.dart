import 'package:dartz/dartz.dart';
import 'package:state_management_provider/core/network_executor/models/network_response.dart';
import 'package:state_management_provider/core/network_executor/models/request_model.dart';
import 'package:state_management_provider/core/network_executor/network_executor.dart';
import 'package:state_management_provider/features/common/domain/entities/api_error.dart';
import 'package:state_management_provider/features/users/data/data_sources/user_data_source.dart';
import 'package:state_management_provider/features/users/data/models/user_model.dart';

class UserRemoteDataSource implements UserDataSource {
  final NetworkExecutor networkExecutor;

  UserRemoteDataSource(this.networkExecutor);

  final String _userUrl = "https://api.github.com/users";

  @override
  Future<Either<ApiErros, List<UserModel>>> getUsers() async {
    final NetworkResponse response = await networkExecutor.getRequest(
      RequestModel(path: _userUrl),
    );

    if (response.statusCode == 200) {
      List<UserModel> list = [];

      for (Map<String, dynamic> jsonData in response.data) {
        list.add((UserModel.fromJson(jsonData)));
      }

      return Right(list);
    } else {
      return Left(
        ApiErros(
          errorMessage: response.data['message'] ?? "Something went wrong",
        ),
      );
    }
  }
}
