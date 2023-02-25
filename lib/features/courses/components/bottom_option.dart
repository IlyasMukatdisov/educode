import 'package:educode/utils/constants.dart';
import 'package:educode/utils/route_names.dart';
import 'package:flutter/material.dart';

class BottomOption extends StatelessWidget {
  const BottomOption({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              openScreen(context, 1);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    color: getSelectedColor(1),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 13, color: getSelectedColor(1)),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              openScreen(context, 2);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: getSelectedColor(2),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "My Courses",
                    style: TextStyle(fontSize: 13, color: getSelectedColor(2)),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              openScreen(context, 3);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: getSelectedColor(3),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Wishlist",
                    style: TextStyle(fontSize: 13, color: getSelectedColor(3)),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              openScreen(context, 4);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.people,
                    color: getSelectedColor(4),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Account",
                    style: TextStyle(fontSize: 13, color: getSelectedColor(4)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getSelectedColor(int optionIndex) {
    return selectedIndex == optionIndex ? kPrimaryColor : Colors.grey.shade800;
  }

  void openScreen(BuildContext context, int selectedOptionNo) {
    String routeName = RouteNames.coursesHome;
    switch (selectedOptionNo) {
      case 2:
        routeName = RouteNames.myCourses;
        break;
      case 3:
        routeName = RouteNames.wishlist;
        break;
      case 4:
        routeName = RouteNames.account;
        break;
    }

    Navigator.of(context).pushReplacementNamed(routeName);
  }
}
