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
      children: List.generate(
        widget.emails.length + 1,
        (index) => index < widget.emails.length
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Text(
                  widget.emails[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Jost',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              )
            : ElevatedButton(
                onPressed: () => widget.onTap(),
                child: const Icon(Icons.add),
              ),
      ),
    );
  }
}
