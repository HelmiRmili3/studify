import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/auth/data/models/user_data_model.dart';

class EmailList extends StatefulWidget {
  final List<UserDataModel> emails;

  const EmailList({
    super.key,
    required this.emails,
  });

  @override
  State<EmailList> createState() => _EmailListState();
}

class _EmailListState extends State<EmailList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.emails.isEmpty)
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Center(
              child: Text(
                'No emails found',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ),
        ...widget.emails.map((email) {
          return Container(
            // padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2),
            margin: EdgeInsets.only(bottom: 5.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(email.imageUrl!),
                ),
                const SizedBox(width: 5),
                Text(
                  email.email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Jost',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
