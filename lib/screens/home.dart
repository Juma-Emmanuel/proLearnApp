import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_course/Controllers/GetCategories.dart';
import 'package:online_course/Controllers/GetFeaturedCourses.dart';
import 'package:online_course/Controllers/GetRecommendedCourses.dart';
import 'package:online_course/Controllers/GetUser.dart';
import 'package:online_course/Models/Category.dart';
import 'package:online_course/Models/Course.dart';
import 'package:online_course/Models/User.dart';
import 'package:online_course/screens/CategoryCourseview.dart';
import 'package:online_course/screens/CourseDetailview.dart';
import 'package:online_course/screens/CoursesView.dart';
import 'package:online_course/theme/color.dart';

import 'package:online_course/widgets/category_box.dart';
import 'package:online_course/widgets/feature_item.dart';
import 'package:online_course/widgets/notification_box.dart';
import 'package:online_course/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetUser getUser = GetUser();
  User? user;
  GetCategories getCategories = GetCategories();
  List<Category> categories = [];

  GetFeaturedCourses getFeaturedCourses = GetFeaturedCourses();
  List<Course> featuredCourses = [];

  GetRecommendedCourses getRecommendedCourses = GetRecommendedCourses();
  List<Course> recommendedCourses = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      User fetchedUser = await getUser.fetchUser();
      List<Category> fetchedCategories = await getCategories.fetchCategories();

      List<Course> fetchedRecommendedCourses =
          await getRecommendedCourses.fetchCourses();

      List<Course> fetchedFeaturedCourses =
          await getFeaturedCourses.fetchCourses();

      setState(() {
        user = fetchedUser;
        categories = fetchedCategories;
        featuredCourses = fetchedFeaturedCourses;
        recommendedCourses = fetchedRecommendedCourses;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching data. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: RefreshIndicator(
        onRefresh: () => fetchData(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: _buildAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildBody(),
                childCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user != null
                  ? Row(
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user!.first_name,
                          style: TextStyle(
                            color: Color(0XFF3B61C0),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        NotificationBox(
          notifiedNumber: 1,
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategories(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "Featured",
              style: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
          _buildFeatured(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textColor),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: AppColor.darker),
                ),
              ],
            ),
          ),
          _buildRecommended(),
        ],
      ),
    );
  }

  Map<String, dynamic> all = {
    "name": "All",
    "icon": "assets/icons/category/all.svg",
  };
  _buildCategories() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 19.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        //  CoursePage(course: courses[index])
                        CoursesView(
                      title: 'All Courses',
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.shadowColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/category/all.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'All',
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: List.generate(
              categories.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CategoryBox(
                  selectedColor: Colors.white,
                  data: categories[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            //  CoursePage(course: courses[index])
                            CategoryCourseView(
                          title: categories[index].name,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildFeatured() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 290,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        featuredCourses.length,
        (index) => FeatureItem(
          data: featuredCourses[index],
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailView(
                  courseId: featuredCourses[index].courseId,
                  name: featuredCourses[index].name,
                  image: featuredCourses[index].image,
                  description: featuredCourses[index].description,
                  price: featuredCourses[index].price,
                  duration: featuredCourses[index].duration,
                  session: featuredCourses[index].session,
                  review: featuredCourses[index].review,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _buildRecommended() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          recommendedCourses.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RecommendItem(
              data: recommendedCourses[index],
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailView(
                      courseId: recommendedCourses[index].courseId,
                      name: recommendedCourses[index].name,
                      image: recommendedCourses[index].image,
                      description: recommendedCourses[index].description,
                      price: recommendedCourses[index].price,
                      duration: recommendedCourses[index].duration,
                      session: recommendedCourses[index].session,
                      review: recommendedCourses[index].review,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
