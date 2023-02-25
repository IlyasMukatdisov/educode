import 'package:educode/features/courses/components/bottom_option.dart';
import 'package:educode/features/courses/components/shopping_cart_option.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomOption(selectedIndex: 4),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const ShoppingCartOption(),
        body: Container(),
      ),
    );
  }
}
