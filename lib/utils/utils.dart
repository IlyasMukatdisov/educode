import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(defaultPadding),
  ));
}