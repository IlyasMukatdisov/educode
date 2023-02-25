import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoursesHeader extends ConsumerWidget {
  const CoursesHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.read(authControllerProvider).currentUser;
    String userName = user?.displayName ?? 'User';
    if (userName.isEmpty) userName = 'User';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome $userName',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Let's learn something new today",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: kOptionColor),
              child: Align(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: kOptionColor),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}
