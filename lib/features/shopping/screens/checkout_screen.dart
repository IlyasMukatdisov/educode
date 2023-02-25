import 'package:csc_picker/csc_picker.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/features/my_courses/provider/my_course_data_provider.dart';
import 'package:educode/features/shopping/provider/shopping_cart_data_provider.dart';
import 'package:educode/model/course.dart';
import 'package:educode/features/shopping/screens/widget/payment_methods.dart';
import 'package:educode/utils/route_names.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.courseList,
    required this.totalPrice,
  });

  final List<Course> courseList;

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  MyCourseDataProvider.addAllCourses(courseList);
                  ShoppingClassDataProvider.clearCart();

                  Utils.showMessage(
                    context: context,
                    message: 'Your order is placed successfully',
                  );

                  Navigator.pushNamed(context, RouteNames.coursesHome);
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
                        leading: Image.asset(
                          course.thumbnailUrl,
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
