import 'package:e_commerce/models/cart.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  final String baseUrl = "https://greentechapi.onrender.com/api";

  Future<http.Response> getProduct({required String token}) async {
    return await http.get(Uri.parse("$baseUrl/products"),
        headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> addCart(
      {required String token, required Cart cart}) async {
    var data = {
      "product_id": cart.productId.toString(),
      "quantity": cart.quantity.toString()
    };
    return await http.post(Uri.parse("$baseUrl/cart"),
        body: data, headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> getCart({required String token}) async {
    return await http.get(Uri.parse("$baseUrl/cart"),
        headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> deleteCart(
      {required String token, required int id}) async {
    return await http.delete(Uri.parse("$baseUrl/cart/$id"),
        headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> clearCart({required String token}) async {
    return await http.delete(Uri.parse("$baseUrl/cart"),
        headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> checkOut({required String token}) async {
    return await http.post(Uri.parse("$baseUrl/cart/checkout"),
        headers: {"Authorization": "Bearer $token"});
  }
}
