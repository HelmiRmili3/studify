import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import '../widgets/email_list.dart';
import '../widgets/email_text_filed.dart';

class FiliereDetails extends StatefulWidget {
  final String code;
  const FiliereDetails({
    super.key,
    required this.code,
  });

  @override
  State<FiliereDetails> createState() => _FiliereDetailsState();
}

class _FiliereDetailsState extends State<FiliereDetails> {
  TextEditingController filiereName = TextEditingController();
  List<String> emailsProfessors = [
    'mohamed.benali@isimg.tn',
    'amine.chaouch@isimg.tn',
    'sami.meftah@isimg.tn',
    'ahmed.kacem@isimg.tn',
    'khaled.farhat@isimg.tn',
  ];
  List<String> emailsStudents = [
    'yasmine.trabelsi@isimg.tn',
    'sarra.belhadj@isimg.tn',
    'nadia.mansouri@isimg.tn',
    'leila.chaabane@isimg.tn',
    'hana.karoui@isimg.tn',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.code),
      resizeToAvoidBottomInset:
          true, // This allows resizing when the keyboard shows up
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Professors",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                child: EmailList(
                  emails: emailsProfessors,
                  onTap: () {
                    _showBottomSheet(context);
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Students",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                child: EmailList(
                  emails: emailsStudents,
                  onTap: () {
                    _showBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Builder(
            builder: (context) {
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
              final bottomSheetHeight = keyboardHeight + 100;

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                height: bottomSheetHeight,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Email TextField
                      Expanded(
                        child: EmailTextField(controller: emailController),
                      ),
                      SizedBox(
                          width:
                              10.w), // Add spacing between TextField and Button
                      // ElevatedButton
                      GestureDetector(
                        onTap: () {
                          if (emailController.text.isNotEmpty) {
                            setState(() {
                              emailsProfessors
                                  .add('${emailController.text}@isimg.tn');
                            });
                          }
                          Navigator.pop(context);
                        },
                        child: Icon(
                          EneftyIcons.arrow_right_bold,
                          size: 34.sp,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
