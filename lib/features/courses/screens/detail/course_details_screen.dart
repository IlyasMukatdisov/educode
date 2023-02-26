import 'package:cached_network_image/cached_network_image.dart';
import 'package:educode/features/shopping/repository/shopping_cart_repository.dart';
import 'package:educode/features/wishlist/repository/wishlist_repository.dart';
import 'package:educode/utils/widgets/loading_overlay.dart';
import 'package:educode/model/course.dart';
import 'package:educode/model/section.dart';
import 'package:educode/features/courses/screens/detail/widget/favorite_option.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

class CoursesDetailsScreen extends ConsumerWidget {
  CoursesDetailsScreen({super.key, required this.course});

  final greyTextStyle = TextStyle(fontSize: 15, color: Colors.grey.shade600);

  final Course course;

  Future<void> addToCart(
      Course course, BuildContext context, WidgetRef ref) async {
    int result = await ref
        .read(firebaseShoppingCartRepositoryProvider)
        .addCourse(course: course, context: context);
    String message = 'Course added to cart';
    if (result == 1) {
      message = "Can't add course to shopping cart";
    }
    if (result == 2) {
      message = 'You have already added this course to the cart';
    }
    if (context.mounted) {
      Utils.showMessage(
        context: context,
        message: message,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: LoadingOverlay(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Row(
                children: [
                  const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Utils.openShoppingCart(context);
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
          body: FutureBuilder(
            future: ref
                .read(wishlistRepositoryProvider)
                .getCourses(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  bool isFavorite = false;
                  List<Course> wishCourses = snapshot.data!;
                  for (var wCourse in wishCourses) {
                    if (wCourse.id == course.id) isFavorite = true;
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: course.thumbnailUrl,
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.play_arrow,
                                          size: 80,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Preview this course",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        course.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade900,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: kPrimaryColor,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                course.createdBy,
                                                style: const TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 16,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              )
                                            ],
                                          ),
                                          FavoriteOption(
                                            course: course,
                                            isFavorite: isFavorite,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.play_circle_outline),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${course.lessonNo} Lessons',
                                                style: greyTextStyle,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                course.duration,
                                                style: greyTextStyle,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: kRatingColor,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                course.rate.toString(),
                                                style: greyTextStyle,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ReadMoreText(
                                        course.description,
                                        trimLines: 2,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: "Show more",
                                        trimExpandedText: "Show less",
                                        moreStyle: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        lessStyle: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Course Content",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '(${course.sections.length} Sections)',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade800),
                                          )
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: course.sections.length,
                                        itemBuilder: (context, index) {
                                          return buildCourseContent(index);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        margin:
                            const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${course.price}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey.shade900),
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimaryColor),
                                      onPressed: () async {
                                        ref
                                            .read(showLoadingOverlayProvider
                                                .notifier)
                                            .state = true;
                                        await addToCart(course, context, ref);
                                        ref
                                            .read(showLoadingOverlayProvider
                                                .notifier)
                                            .state = false;
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCourseContent(int index) {
    Section section = course.sections[index];
    return ExpansionTile(
      title: Text(
        'Section ${index + 1} - ${section.name}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      children: section.lectures.map((lecture) {
        return ListTile(
          dense: true,
          leading: const SizedBox(),
          title: Text(
            lecture.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 15,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                lecture.duration,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
