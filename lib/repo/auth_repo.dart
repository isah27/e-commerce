import 'package:e_commerce/models/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = "https://greentechapi.onrender.com/api";
  Future<http.Response> register(
      {required String name,
      required String email,
      required String password}) async {
    var data = {"name": name, "email": email, "password": password};
    return await http.post(Uri.parse("$baseUrl/register"), body: data);
  }

  Future<http.Response> login(
      {required String email, required String password}) async {
    var data = {"email": email, "password": password};

    return await http.post(Uri.parse("$baseUrl/login"), body: data);
  }

  Future<http.Response> getUser({required String token}) async {
    return await http.get(Uri.parse("$baseUrl/user"),
        headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> updateUser(
      {required String token, required UserModel user}) async {
    var data = {"name": user.name, "email": user.email};
    return await http.patch(Uri.parse("$baseUrl/profile"),
        body: data, headers: {"Authorization": "Bearer $token"});
  }
}
