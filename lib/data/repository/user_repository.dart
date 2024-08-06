import 'package:user_app/data/models/user_model.dart';
import 'package:user_app/network/api_service.dart';

class UserRepository {
  final ApiService apiService;
  UserRepository(this.apiService);
  Future<List<User>> fetchUsers() async {
    try {
      return await apiService.getUsers();
    } catch (e) {
      print("Error is UserRepository:${e}");
      rethrow;
    }
  }
}
