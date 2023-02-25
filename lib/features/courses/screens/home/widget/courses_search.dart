import 'package:flutter/material.dart';

class CoursesSearch extends StatelessWidget {
  const CoursesSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Search for Courses",
          prefixIcon: const Icon(Icons.search),
          hintStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.grey.shade400),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(10)),
    );
  }
}
