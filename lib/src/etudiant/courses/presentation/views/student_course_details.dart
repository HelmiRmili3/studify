import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentCourseDetails extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const StudentCourseDetails({
    super.key,
    required this.arguments,
  });

  @override
  State<StudentCourseDetails> createState() => _StudentCourseDetailsState();
}

class _StudentCourseDetailsState extends State<StudentCourseDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // column 1
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                // column 2
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 320.w,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        top: 80.h,
                      ),
                      child: Material(
                        elevation: 8.0,
                        borderRadius: BorderRadius.circular(16.r),
                        shadowColor: Colors.grey.withOpacity(0.2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 30.h,
                                left: 16.w,
                                right: 16.w,
                                bottom: 16.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16.0),
                                _TeacherInfoRow(
                                  teacher: widget.arguments['teacher'],
                                  rating: widget.arguments['rating'],
                                ),
                                const SizedBox(height: 10.0),
                                _CourseTitle(
                                    course: widget.arguments['course']),
                                const SizedBox(height: 10.0),
                                _CourseStats(
                                    students: widget.arguments['students']
                                        .toString()),
                                const SizedBox(height: 20.0),
                                Flexible(
                                  child: _TabSection(
                                    controller: _tabController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Instructor",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Jost',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: const AssetImage(
                              'assets/images/default_avatar.png'),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'William S. Cunningham',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontFamily: 'Jost',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Graphic Design',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontFamily: 'Jost',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0XFF545454),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const Divider(
                      color: Color(0XFFD9D9D9),
                      thickness: 1.0,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Extracted widget for displaying teacher info with rating
class _TeacherInfoRow extends StatelessWidget {
  final String? teacher;
  final double? rating;

  const _TeacherInfoRow({this.teacher, this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teacher ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Mulish',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF6B00),
              ),
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 16.sp),
            Text(
              rating?.toString() ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Mulish',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

// Extracted widget for displaying course title
class _CourseTitle extends StatelessWidget {
  final String? course;

  const _CourseTitle({this.course});

  @override
  Widget build(BuildContext context) {
    return Text(
      course ?? '',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: 'Jost',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

// Extracted widget for course statistics (students and time)
class _CourseStats extends StatelessWidget {
  final String? students;

  const _CourseStats({super.key, this.students});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.group, color: const Color(0xFFFF6B00), size: 16.sp),
            const SizedBox(width: 5.0),
            Text(
              '$students student',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Jost',
                    fontSize: 14.sp,
                  ),
            ),
            const SizedBox(width: 10.0),
            Container(width: 2, height: 16.h, color: Colors.black),
            const SizedBox(width: 10.0),
            Icon(Icons.access_time,
                color: const Color(0xFFFF6B00), size: 16.sp),
            const SizedBox(width: 5.0),
            Text(
              '22 Hours',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Mulish',
                    fontSize: 14.sp,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TabSection extends StatefulWidget {
  final TabController controller;

  const _TabSection({required this.controller});

  @override
  _TabSectionState createState() => _TabSectionState();
}

class _TabSectionState extends State<_TabSection> {
  @override
  Widget build(BuildContext context) {
    final List<CurriculumItem> curriculum = [
      const CurriculumItem(
        title: "Introduction to Flutter",
        time: "20 Mins",
        index: "01",
      ),
      const CurriculumItem(
        title: "Understanding Dart Basics",
        time: "25 Mins",
        index: "02",
      ),
      const CurriculumItem(
        title: "Building Layouts in Flutter",
        time: "15 Mins",
        index: "03",
      ),
      const CurriculumItem(
        title: "State Management",
        time: "30 Mins",
        index: "04",
      ),
      const CurriculumItem(
        title: "Networking in Flutter Apps",
        time: "40 Mins",
        index: "05",
      ),
      const CurriculumItem(
        title: "State Management",
        time: "30 Mins",
        index: "04",
      ),
      const CurriculumItem(
        title: "Networking in Flutter Apps",
        time: "40 Mins",
        index: "05",
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: widget.controller,
          labelStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Mulish',
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Mulish',
            color: Colors.black,
          ),
          indicatorColor: null,
          tabs: const [
            Tab(text: 'Curriculum'),
            Tab(text: 'About'),
          ],
        ),
        SizedBox(
          height: 550.h,
          child: TabBarView(
            controller: widget.controller,
            children: [
              _CurriculumTabContent(curriculum: curriculum),
              _AboutTabContent(),
            ],
          ),
        ),
      ],
    );
  }
}

// About Tab Content
class _AboutTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Graphic Design now a popular profession graphic design by off your career...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 13.sp,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            "Graphic Design is a popular profession with growing opportunities...",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 13.sp,
                ),
          ),
        ],
      ),
    );
  }
}

// Curriculum Tab Content
class _CurriculumTabContent extends StatefulWidget {
  final List<CurriculumItem> curriculum;
  const _CurriculumTabContent({
    required this.curriculum,
  });
  @override
  State<_CurriculumTabContent> createState() => _CurriculumTabContentState();
}

class _CurriculumTabContentState extends State<_CurriculumTabContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Section 01",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Jost',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: widget.curriculum.map((item) {
              return CurriculumItem(
                title: item.title,
                time: item.time,
                index: item.index,
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class CurriculumItem extends StatelessWidget {
  final String title;
  final String time;
  final String index;

  const CurriculumItem({
    super.key,
    required this.title,
    required this.time,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Text(
                  index,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Jost',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 10),
              // Wrap the Column with Expanded
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title.length > 22
                          ? '${title.substring(0, 22)}...'
                          : title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Jost',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                      maxLines: 2, // Restrict to a single line
                    ),
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Mulish',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 30.w,
            child: const Icon(Icons.video_file),
          ),
        ],
      ),
    );
  }
}
