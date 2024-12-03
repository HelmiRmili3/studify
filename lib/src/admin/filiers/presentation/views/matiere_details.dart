import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/utils/helpers.dart';
import '../../../../../models/matiere.dart';
import '../../../../common/auth/data/models/user_data_model.dart';
import '../widgets/email_dropdown.dart';

class MatiereDetails extends StatefulWidget {
  final Matiere matiere;
  final List<UserDataModel> professorsEmails;
  const MatiereDetails({
    super.key,
    required this.matiere,
    required this.professorsEmails,
  });

  @override
  State<MatiereDetails> createState() => _MatiereDetailsState();
}

class _MatiereDetailsState extends State<MatiereDetails> {
  @override
  void initState() {
    print('professor: ${widget.professorsEmails.length}');
    print('matiere: ${widget.matiere.professor}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDataModel? selectedProfessor = widget.professorsEmails
        .where((professor) => professor.id == widget.matiere.professor)
        .first;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: 500.h,
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          children: [
            ClipRRect(
              child: Container(
                width: double.infinity,
                height: 200.h,
                color: Colors.grey[300],
                child: Image.network(
                  widget.matiere.coverPhoto!.filepath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.matiere.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Jost',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16.sp),
                            Text(
                              widget.matiere.coefficient,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontFamily: 'Mulish',
                                    fontSize: 11.sp,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5.w),
                        Container(
                          width: 2,
                          height: 16.h,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '${widget.matiere.part.name.toUpperCase()} ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'Mulish',
                                    fontSize: 14.sp,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${selectedProfessor.firstName.capitalizeFirst()} ${selectedProfessor.lastName.capitalizeFirst()}",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontFamily: 'Mulish',
                                    fontSize: 12.sp,
                                    color: const Color(0xFFFF6B00),
                                  ),
                        ),
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor:
                              const Color(0xFFFF6B00).withOpacity(.5),
                          child: Text(widget.matiere.type.name.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontFamily: 'Mulish',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    EmailDropdown(
                      emailEntities: widget.professorsEmails,
                      matiere: widget.matiere,
                      initEmail: selectedProfessor,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
