import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:user_app/data/models/user_model.dart';

part 'api_service.g.dart';

class Apis {
  static const String user = "/users";
  static const String id = "/user/{id}";
}

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(Apis.user)
  Future<List<User>> getUsers();
  @GET(Apis.id)
  Future<User> getUserDetail(@Path("id") int id);
}
