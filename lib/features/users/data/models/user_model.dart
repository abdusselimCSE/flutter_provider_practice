import 'package:state_management_provider/features/common/data/models/base_model.dart';
import 'package:state_management_provider/features/users/domain/entities/user.dart';

class UserModel implements BaseModel<User> {
  final String? userName;
  final int id;
  final String? nodeId;
  final String? avatarUrl;
  final String? url;

  UserModel({
    required this.userName,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.url,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      userName: jsonData['login'],
      id: jsonData['id'],
      nodeId: jsonData['node_id'],
      avatarUrl: jsonData['avatar_url'],
      url: jsonData['url'],
    );
  }

  @override
  toEntity() {
    return User(
      userName: userName ?? 'Unknown',
      id: id,
      nodeId: nodeId ?? '',
      avatarUrl: avatarUrl ?? '',
      url: url ?? '',
    );
  }
}
