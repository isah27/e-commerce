import 'package:e_commerce/screens/auth/login.dart';
import 'package:e_commerce/screens/auth/signup.dart';
import 'package:e_commerce/screens/cart/cart.dart';
import 'package:e_commerce/screens/products/detail_product.dart';
import 'package:e_commerce/screens/products/view_product.dart';
import 'package:e_commerce/screens/user/account_datail.dart';
import 'package:e_commerce/screens/user/user_profile.dart';
import 'package:flutter/cupertino.dart';

import 'custom_page_route.dart';

class AppRoute {
  static const String login = '/';
  static const String register = '/register';
  static const String userProfile = '/user-profile';
  static const String accountDetail = '/account-details';
  static const String home = '/home-page';
  static const String detailProduct = '/detail-product';
  static const String cart = '/cart-page';
  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return CustomPageRoute(child:  LoginPage());
      case register:
        return CustomPageRoute(
          direction: AxisDirection.left,
          child:  SignUpPage(),
        );
      case userProfile:
        return CustomPageRoute(child: const UserProfile());
      case home:
        return CustomPageRoute(child: const HomePage());
      case accountDetail:
        return CustomPageRoute(child: const AccountDetail());
      case detailProduct:
        return CustomPageRoute(child: const DetailProduct());
        case cart:
        return CustomPageRoute(child: const CartPage());

      default:
        return CustomPageRoute(child:  LoginPage());
    }
  }
}
