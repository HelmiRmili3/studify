import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import '../../../../../core/utils/file_picker_helper.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';
import '../widgets/custom_text_filed_with_attachements.dart';
import '../widgets/files_list.dart';

class ProfessorAddNewDoc extends StatefulWidget {
  const ProfessorAddNewDoc({super.key});

  @override
  State<ProfessorAddNewDoc> createState() => _AddChapterScreenState();
}

class _AddChapterScreenState extends State<ProfessorAddNewDoc> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<PlatformFile> _uploadedFiles = [];

  Future<void> _pickFiles() async {
    final result = await FilePickerHelper.pickFiles();
    if (result != null) {
      setState(() {
        _uploadedFiles = result.files;
      });
    }
  }

  void _submitForm() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_uploadedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload at least one file.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Submit your data here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        action: [
          IconButton(
            onPressed: () => _pickFiles(),
            icon: const Icon(Icons.attach_file),
          ),
          IconButton(
            onPressed: () => _submitForm(),
            icon: const Icon(Icons.send),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Subject',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                hintText: 'Enter the chapter title',
                controller: _titleController,
                keyboardType: TextInputType.text,
                maxLines: 2,
              ),
              SizedBox(height: 16.h),

              // Content Text Field
              Text(
                'Content',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFieldWithAttachements(
                  hintText: 'Enter the content here',
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                  isPassword: false,
                  bottomChild: FileList(
                    onRemoveFile: (file) {},
                    uploadedFiles: _uploadedFiles,
                  )),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
