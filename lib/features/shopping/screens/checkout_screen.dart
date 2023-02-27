import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:educode/features/my_courses/repository/my_courses_repository.dart';
import 'package:educode/features/shopping/repository/shopping_cart_repository.dart';
import 'package:educode/model/my_course.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/model/course.dart';
import 'package:educode/features/shopping/screens/widget/payment_methods.dart';
import 'package:educode/utils/route_names.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({
    super.key,
    required this.courseList,
    required this.totalPrice,
  });

  final List<Course> courseList;

  final double totalPrice;

  Future<int> checkout(WidgetRef ref, BuildContext context) async {
    List<MyCourse> myCourses = [];
    for (var course in courseList) {
      myCourses.add(
        MyCourse(course, 0),
      );
    }

    int result = await ref
        .read(myCoursesRepositoryProvider)
        .addCourses(myCourses: myCourses, context: context);
    return result;
  }

  void cleanCart(WidgetRef ref, BuildContext context) {
    ref
        .read(firebaseShoppingCartRepositoryProvider)
        .clearCart(context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          backgroundColor: kPrimaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$totalPrice',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                onPressed: () async {
                  int result = await checkout(ref, context);
                  if (result == 0) {
                    if (context.mounted) {
                      cleanCart(ref, context);
                      Utils.showMessage(
                        context: context,
                        message: 'Your order is placed successfully',
                      );
                      Navigator.pushNamed(context, RouteNames.coursesHome);
                    }
                  } else {
                    if (context.mounted) {
                      Utils.showMessage(
                        context: context,
                        message: 'Something went wrong! Please try again later',
                      );
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Place order',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing Address',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CSCPicker(
                    layout: Layout.vertical,
                    flagState: CountryFlag.DISABLE,
                    onCountryChanged: (value) {},
                    onStateChanged: (value) {},
                    onCityChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const PaymentMethods(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseList.length,
                    itemBuilder: (context, index) {
                      Course course = courseList[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: course.thumbnailUrl,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Text(
                          '\$${course.price}',
                          style: const TextStyle(fontSize: 17),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
