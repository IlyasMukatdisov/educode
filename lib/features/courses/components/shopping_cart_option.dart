import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/material.dart';

class ShoppingCartOption extends StatelessWidget {
  const ShoppingCartOption({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      onPressed: () {
        Utils.openShoppingCart(context);
      },
      child: const Icon(Icons.shopping_cart),
    );
  }
}
