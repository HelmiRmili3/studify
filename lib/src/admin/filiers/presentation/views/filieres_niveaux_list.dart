import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import 'filiere_details.dart';

class FilieresNiveauxList extends StatelessWidget {
  final String code;
  final String name;
  final int nbYears;
  final String image;
  const FilieresNiveauxList({
    super.key,
    required this.code,
    required this.name,
    required this.nbYears,
    required this.image,
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
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 100.h,
                              width: 106.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context).splashColor,
                              ),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10, // Adjust to position the banner correctly
                            right:
                                -35, // Adjust to position the banner correctly
                            child: Transform.rotate(
                              angle:
                                  0.785398, // Rotates the banner (45 degrees in radians)
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                color: Colors
                                    .red, // Background color for the banner
                                child: Text(
                                  '$code${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white, // Text color
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
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
