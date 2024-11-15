import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_search_filed.dart';
import '../../../../../models/card_data.dart';
import '../widgets/custom_row_title.dart';
import '../widgets/schedule_list_card.dart';
import '../widgets/courses_list.dart';
import '../widgets/professors_list.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _EtudiantHomeScreenState();
}

class _EtudiantHomeScreenState extends State<StudentHomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );

    List<String> categories = [
      'All',
      'Courses',
      'Traveaux dirigé',
      'Traveaux pratiques',
    ];
    List<Map<String, dynamic>> courses = [
      {
        "teacher": "John Doe",
        "course": "Flutter Development",
        "price": 100.0,
        "rating": 4.5,
        "students": 150,
      },
      {
        "teacher": "Alice Smith",
        "course": "React Native Bootcamp",
        "price": 120.0,
        "rating": 4.7,
        "students": 200,
      },
      {
        "teacher": "Robert Johnson",
        "course": "Python for Data Science",
        "price": 90.0,
        "rating": 4.8,
        "students": 300,
      },
      {
        "teacher": "Emma Wilson",
        "course": "Web Development with JavaScript",
        "price": 80.0,
        "rating": 4.3,
        "students": 250,
      },
      {
        "teacher": "Chris Brown",
        "course": "Machine Learning Basics",
        "price": 150.0,
        "rating": 4.9,
        "students": 180,
      },
    ];
    final List<String> professors = [
      'Dr. Smith',
      'Prof. Johnson',
      'Dr. Williams',
      'Prof. Brown',
      'Dr. Jones',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomSearchField(
            prefixIcon: EneftyIcons.search_normal_2_outline,
            suffixIcon: EneftyIcons.setting_3_outline,
            hintText: 'Search for..',
            controller: searchController,
          ),
          SizedBox(height: 20.h),
          ScheduleListCard(
            imageUrl: 'assets/images/homebg.png',
            cards: [
              CardData(
                time: '09:55 - 11:25',
                course: 'CI Préparation TOEIC',
                instructor: 'Mounira Jabnoune',
                location: 'LabLangues',
                onTap: () {
                  // print('Card 1 tapped');
                },
              ),
              CardData(
                time: '11:30 - 13:00',
                course: 'Advanced Mathematics',
                instructor: 'Ali Ben Salem',
                location: 'Room 203',
                onTap: () {
                  debugPrint('Card 2 tapped');
                },
              ),
              CardData(
                time: '13:30 - 15:00',
                course: 'Computer Science 101',
                instructor: 'Sami Trabelsi',
                location: 'Computer Lab',
                onTap: () {
                  debugPrint('Card 3 tapped');
                },
              ),
            ],
          ),
          SizedBox(height: 20.h),
          CustomRowTitle(
            title: "Categories",
            onViewAll: () {},
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 30.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint('${categories[index]} Cliked');
                  },
                  child: Container(
                    height: 30.h,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: 'Mulish',
                              fontSize: 13.sp,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          CustomRowTitle(
            title: "Popular Courses",
            onViewAll: () {},
          ),
          SizedBox(height: 20.h),
          CoursesList(courses: courses),
          SizedBox(height: 20.h),
          CustomRowTitle(
            title: "Top Mentors",
            onViewAll: () {},
          ),
          SizedBox(height: 20.h),
          ProfessorList(
            professors: professors,
            onItemTap: (index) {
              debugPrint('Tapped on ${professors[index]}');
            },
          ),
          SizedBox(height: 90.h),
        ],
      ),
    );
  }
}
