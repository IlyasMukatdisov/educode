import 'package:educode/features/wishlist/repository/wishlist_repository.dart';
import 'package:educode/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteOption extends ConsumerStatefulWidget {
  FavoriteOption({super.key, required this.course, required this.isFavorite});

  final Course course;
  bool isFavorite;

  @override
  ConsumerState<FavoriteOption> createState() => _FavoriteOptionState();
}

class _FavoriteOptionState extends ConsumerState<FavoriteOption> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          setState(
            () {
              widget.isFavorite = !widget.isFavorite;
              if (widget.isFavorite) {
                ref
                    .read(wishlistRepositoryProvider)
                    .addCourse(course: widget.course, context: context);
              } else {
                ref
                    .read(wishlistRepositoryProvider)
                    .deleteCourse(course: widget.course, context: context);
              }
            },
          );
        },
        icon: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink,
        ));
  }
}
