import 'package:state_management_provider/features/common/domain/entities/api_error.dart';
import 'package:state_management_provider/features/users/domain/entities/user.dart';

sealed class FetchUsersState {}

class FetchUsersInitialState extends FetchUsersState {}

class FetchUsersLoadingState extends FetchUsersState {}

class FetchUsersFetchedState extends FetchUsersState {
  final List<User> users;

  FetchUsersFetchedState({required this.users});
}

class FetchUsersFailedState extends FetchUsersState {
  final ApiErros apiError;

  FetchUsersFailedState({required this.apiError});
}
