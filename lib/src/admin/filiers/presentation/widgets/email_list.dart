import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailList extends StatefulWidget {
  final List<String> emails;
  final Function onTap;

  const EmailList({
    super.key,
    required this.emails,
    required this.onTap,
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
        // Display "No emails found" message when the email list is empty
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
        // Display the emails when the list is not empty
        ...widget.emails.map((email) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            margin: EdgeInsets.only(bottom: 5.h),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(.5),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Jost',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          );
        }),
        ElevatedButton(
          onPressed: () => widget.onTap(),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
