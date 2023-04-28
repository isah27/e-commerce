import 'package:flutter/material.dart';

class BasketImg extends StatelessWidget {
  const BasketImg({
    super.key,
    required this.size,
    this.register=false,
  });

  final Size size;
  final bool register;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/basket.png',
      height:register?size.height*0.2: size.height * 0.3,
      width:register?size.width*0.5: size.width * 0.6,
      fit: BoxFit.fill,
    );
  }
}
