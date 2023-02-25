
import 'package:educode/features/courses/components/bottom_option.dart';
import 'package:educode/features/courses/components/shopping_cart_option.dart';
import 'package:educode/features/courses/screens/wishlist/widget/wishlist.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const ShoppingCartOption(),
        bottomNavigationBar: const BottomOption(selectedIndex: 3),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wishlist',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900),
                ),
                const SizedBox(
                  height: 10,
                ),
                const WishList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
