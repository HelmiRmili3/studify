import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import 'filiere_details.dart';

class FilieresNiveauxList extends StatelessWidget {
  final String code;
  final String name;
  final int nbYears;
  const FilieresNiveauxList({
    super.key,
    required this.code,
    required this.name,
    required this.nbYears,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: code),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filiere",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              Text(
                name.trim(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Niveaux",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 200.h,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: nbYears,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FiliereDetails(
                              code: '$code${index + 1}',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).splashColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            '$code${index + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontFamily: 'Jost',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
