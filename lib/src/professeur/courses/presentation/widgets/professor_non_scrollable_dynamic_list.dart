import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/models/matiere.dart';

class ProfessorNonScrollableDynamicList extends StatefulWidget {
  final List<Doc> items;
  final Widget Function(Doc item) itemBuilder;

  const ProfessorNonScrollableDynamicList({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  @override
  State<ProfessorNonScrollableDynamicList> createState() =>
      _ProfessorNonScrollableDynamicListState();
}

class _ProfessorNonScrollableDynamicListState
    extends State<ProfessorNonScrollableDynamicList> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Padding(
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
      );
    } else {
      return ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return widget.itemBuilder(widget.items[index]);
        },
      );
    }
  }
}
