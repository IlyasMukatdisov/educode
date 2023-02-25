import 'package:educode/utils/route_names.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showMessage({
    required BuildContext context,
    required String message,
  }) {
    showMessageWithAction(context: context, message: message);
  }

  static void showMessageWithAction({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        action: actionLabel != null
            ? SnackBarAction(label: actionLabel, onPressed: onPressed!)
            : null,
        content: Text(message),
      ),
    );
  }

  static void openShoppingCart(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.shoppingCart);
  }
}
