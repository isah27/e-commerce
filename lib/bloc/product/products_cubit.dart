import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/repo/product_repo.dart';
import 'package:equatable/equatable.dart';

import '../../models/product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductRepo productRepo;
  ProductsCubit(this.productRepo) : super(ProductsInitialState());
  List<Product> products = [];
  Product product = Product();
  List<Cart> carts = [];
  int productQuantity = 1;

  getProduct({required String token}) async {
    emit(ProductsLoadingState());
    try {
      final response = await productRepo.getProduct(token: token);
      if (response.statusCode == 200) {
        for (var product in json.decode(response.body)) {
          products.add(Product.fromJson(product));
        }
        emit(ProductsLoadedState());
      } else {
        emit(ProductsErrorState(error: json.decode(response.body)["message"]));
      }
    } catch (e) {
      emit(ProductsErrorState(error: e.toString()));
    }
  }

  goToDetail({required Product prod}) {
    emit(ProductsLoadingState());
    productQuantity = 1;
    product = prod;
    emit(ProductsLoadedState());
  }

  increment() {
    emit(ProductsLoadingState());
    productQuantity += 1;
    emit(ProductsInitialState());
  }

  decrement() {
    emit(ProductsLoadingState());
    productQuantity -= 1;
    emit(ProductsInitialState());
  }
  // cart

  addCart({required String token}) async {
    emit(ProductsLoadingState());
    Cart cart = Cart(quantity: productQuantity, productId: product.id);
    try {
      final response = await productRepo.addCart(token: token, cart: cart);
      if (response.statusCode == 200) {
        await getCart(token: token);
        emit(ProductsLoadedState());
      } else {
        emit(ProductsErrorState(error: json.decode(response.body)["message"]));
      }
    } catch (e) {
      log(e.toString());
      emit(ProductsErrorState(error: e.toString()));
    }
  }

  getCart({required String token}) async {
    emit(ProductsLoadingState());

    try {
      final response = await productRepo.getCart(token: token);
      if (response.statusCode == 200) {
        List<Cart> cartss = [];
        for (var cart in json.decode(response.body)) {
          cartss.add(Cart.fromJson(cart));
        }
        carts = cartss;
        emit(ProductsInitialState());
      } else {
        emit(ProductsErrorState(error: json.decode(response.body)["message"]));
      }
    } catch (e) {
      emit(ProductsErrorState(error: e.toString()));
    }
  }

  deleteCart({required String token, required Cart cart}) async {
    emit(ProductsLoadingState());

    try {
      final response = await productRepo.deleteCart(token: token, id: cart.id!);
      if (response.statusCode == 200) {
        carts.remove(cart);
        emit(ProductsLoadedState());
      } else {
        emit(ProductsErrorState(error: json.decode(response.body)["message"]));
      }
    } catch (e) {
      emit(ProductsErrorState(error: e.toString()));
    }
  }

  clearCart({required String token}) async {
    emit(ProductsLoadingState());

    try {
      final response = await productRepo.clearCart(token: token);
      if (response.statusCode == 200) {
        carts.clear();
        emit(ProductsLoadedState());
      } else {
        emit(ProductsErrorState(error: json.decode(response.body)["message"]));
      }
    } catch (e) {
      emit(ProductsErrorState(error: e.toString()));
    }
  }


   checkOut({required String token}) async {
    emit(ProductsLoadingState());
    try {
      final response = await productRepo.checkOut(token: token);
      if (response.statusCode == 200) {
        carts.clear();
        emit(ProductsCheckOutState());
      } else {
        emit(ProductsErrorState(error: json.decode(response.body)["message"]));
      }
    } catch (e) {
      emit(ProductsErrorState(error: e.toString()));
    }
  }
}
