import 'package:educode/features/shopping/arguments/checkout_arguments.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/features/shopping/provider/shopping_cart_data_provider.dart';
import 'package:educode/model/course.dart';
import 'package:educode/utils/route_names.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Course> shoppingCartCourses =
      ShoppingClassDataProvider.shoppingCartCourseList;

  double calculateTotal() {
    return ShoppingClassDataProvider.shoppingCartCourseList
        .fold(0, (previousValue, course) => previousValue + course.price);
  }

  Widget createShoppingCartItem(int index) {
    Course course = shoppingCartCourses[index];
    return Card(
      child: ListTile(
        leading: Image.asset(course.thumbnailUrl),
        title: Text(
          course.title,
          maxLines: 2,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By ${course.createdBy}',
              style: const TextStyle(color: kPrimaryColor),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(course.duration),
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('${course.lessonNo} lessons'),
              ],
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${course.price} \$'),
            InkWell(
              onTap: () {
                setState(() {
                  ShoppingClassDataProvider.deleteCourse(course);
                });
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
          backgroundColor: kPrimaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            height: 50,
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: shoppingCartCourses.isNotEmpty
                      ? kPrimaryColor
                      : Colors.grey.shade400),
              onPressed: shoppingCartCourses.isNotEmpty
                  ? () {
                      Navigator.of(context).pushNamed(
                        RouteNames.checkout,
                        arguments: CheckoutArguments(
                          shoppingCartCourses,
                          calculateTotal(),
                        ),
                      );
                    }
                  : null,
              child: const Text(
                'Checkout',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                        fontSize: 20, color: Colors.black.withOpacity(0.8)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '${calculateTotal().toString()} \$',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Promotion',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  SizedBox(
                    width: width > 350 ? 300 : width * 0.7,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder().copyWith(
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          hintText: 'Enter Promocode',
                          filled: true,
                          contentPadding: const EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor),
                      onPressed: () {},
                      child: const Text('Apply'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${shoppingCartCourses.length} Courses in List',
                style: const TextStyle(fontSize: 18),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: shoppingCartCourses.length,
                  itemBuilder: (context, index) {
                    return createShoppingCartItem(index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
