import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/models/matiere.dart';

class NonScrollableDynamicList extends StatefulWidget {
  final List<Matiere> items;
  final Widget Function(Matiere item) itemBuilder;

  const NonScrollableDynamicList({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  @override
  State<NonScrollableDynamicList> createState() =>
      _NonScrollableDynamicListState();
}

class _NonScrollableDynamicListState extends State<NonScrollableDynamicList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Display "No items found" message when the item list is empty
        if (widget.items.isEmpty)
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Center(
              child: Text(
                'No items found',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ),
        // Display the items when the list is not empty
        ...widget.items.map((item) {
          return widget.itemBuilder(item);
        }),
      ],
    );
  }
}
