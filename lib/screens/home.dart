import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_course/Controllers/GetCategories.dart';
import 'package:online_course/Controllers/GetFeaturedCourses.dart';
import 'package:online_course/Controllers/GetUser.dart';
import 'package:online_course/Models/Category.dart';
import 'package:online_course/Models/Course.dart';
import 'package:online_course/Models/User.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
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

  GetRecommendedCourses getFeaturedCourses = GetRecommendedCourses();
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
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
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

  _buildCategories() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CategoryBox(
              selectedColor: Colors.white,
              data: categories[index],
              onTap: () {},
            ),
          ),
        ),
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
            ),
          ),
        ),
      ),
    );
  }
}
