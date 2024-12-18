import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/course_title.dart';
import '../../../../../core/common/widgets/tab_section.dart';
import '../../../../../core/common/widgets/teacher_info_row.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../models/matiere.dart';

class ProfessorMatiereDetails extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const ProfessorMatiereDetails({
    super.key,
    required this.arguments,
  });

  @override
  State<ProfessorMatiereDetails> createState() =>
      _ProfessorMatiereDetailsState();
}

class _ProfessorMatiereDetailsState extends State<ProfessorMatiereDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Matiere matiere = Matiere.fromJson(widget.arguments);
    // var professor = FirebaseApp.instance.options.projectId == 'studify-27720'
    // var professor = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceMaterialTransparency: true,
            expandedHeight: 200.0.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      matiere.coverPhoto!.filepath,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 90.h,
                      left: 16.w,
                      right: 16.w,
                      bottom: 16.w,
                    ),
                    child: Container(
                      width: 190.w,
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white30,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2.r,
                            blurRadius: 5.r,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.0.h),
                          const TeacherInfoRow(
                            teacher: 'PROFESSOR',
                            rating: 4.5,
                          ),
                          SizedBox(height: 10.0.h),
                          CourseTitle(course: matiere.name),
                          SizedBox(height: 10.0.h),
                          const CourseStats(
                            students: '120',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: TabSection(
                controller: _tabController,
                matiere: matiere,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          GoRouter.of(context).pushNamed(
            RoutesNames.professorAddNewDoc,
            extra: matiere.toJson(),
          );
        },
        backgroundColor: Colors.blueAccent.shade200,
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        label: const Text(
          'Compose',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
