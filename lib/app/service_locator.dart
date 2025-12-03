import 'package:get_it/get_it.dart';
import 'package:state_management_provider/app/set_up_dio.dart';
import 'package:state_management_provider/core/network_executor/error_mapper/default_error_mapper.dart';
import 'package:state_management_provider/core/network_executor/network_executor.dart';
import 'package:state_management_provider/features/users/data/data_sources/user_data_source.dart';
import 'package:state_management_provider/features/users/data/data_sources/user_remote_data_source.dart';
import 'package:state_management_provider/features/users/data/repositories/user_repository_implemented.dart';
import 'package:state_management_provider/features/users/domain/repositories/user_repository.dart';
import 'package:state_management_provider/features/users/domain/usecases/fetch_users_use_case.dart';

//Registry
//uses linked hashmap
final GetIt serviceLocator = GetIt.instance;

void setUpServiceLocator() {
  serviceLocator.registerSingleton(
    NetworkExecutor(
      dio: getDioInstance(),
      errorMapper: DefaultErrorMapper(onUnauthorize: () {}),
    ),
  );

  serviceLocator.registerSingleton<UserDataSource>(
    UserRemoteDataSource(serviceLocator()),
  );

  serviceLocator.registerSingleton<UserRepository>(
    UserRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerSingleton<FetchUsersUseCase>(
    FetchUsersUseCase(serviceLocator()),
  );
}
