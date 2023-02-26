import 'package:cached_network_image/cached_network_image.dart';
import 'package:educode/features/shopping/arguments/checkout_arguments.dart';
import 'package:educode/features/shopping/repository/shopping_cart_repository.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/model/course.dart';
import 'package:educode/utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  Future<List<Course>> getShoppingCartCourses() async {
    return await ref
        .read(firebaseShoppingCartRepositoryProvider)
        .getCourses(context: context);
  }

  double calculateTotal(List<Course> courses) {
    return courses.fold(
        0, (previousValue, course) => previousValue + course.price);
  }

  Widget createShoppingCartItem(Course course) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(imageUrl: course.thumbnailUrl),
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
                  ref
                      .read(firebaseShoppingCartRepositoryProvider)
                      .deleteCourse(course: course, context: context);
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
      child: FutureBuilder(
        future: getShoppingCartCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Course> courses = snapshot.data!;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Shopping Cart'),
                  backgroundColor: kPrimaryColor,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: courses.isNotEmpty
                              ? kPrimaryColor
                              : Colors.grey.shade400),
                      onPressed: courses.isNotEmpty
                          ? () {
                              Navigator.of(context).pushNamed(
                                RouteNames.checkout,
                                arguments: CheckoutArguments(
                                  courses,
                                  calculateTotal(courses),
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
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${calculateTotal(courses).toString()} \$',
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor)),
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
                        '${courses.length} Courses in List',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            return createShoppingCartItem(courses[index]);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
