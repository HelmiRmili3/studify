import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/common/widgets/fading_circle_loading_indicator.dart';
import 'package:studify/src/professeur/courses/presentation/blocs/matiere/matiere_states.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/app_snack_bar.dart';
import '../../../../../core/utils/file_picker_helper.dart';
import '../../../../../models/matiere.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';
import '../blocs/matiere/matiere_bloc.dart';
import '../blocs/matiere/matiere_events.dart';
import '../widgets/custom_text_filed_with_attachements.dart';
import '../widgets/files_list.dart';

class ProfessorAddNewDoc extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const ProfessorAddNewDoc({
    super.key,
    this.arguments,
  });

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

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _uploadedFiles.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Matiere matiere = Matiere.fromJson(widget.arguments!);
    void submitForm() {
      final title = _titleController.text;
      final content = _contentController.text;

      if (title.isEmpty || content.isEmpty) {
        AppSnackBar.showTopSnackBar(
          context,
          'Please fill all fields.',
          Colors.yellow,
        );

        return;
      }

      if (_uploadedFiles.isEmpty) {
        AppSnackBar.showTopSnackBar(
          context,
          'Please upload at least one file.',
          Colors.yellow,
        );

        return;
      }

      context.read<MatiereBloc>().add(AddDoc(
            Doc(
              id: const Uuid().v1(),
              title: title,
              message: content,
              creator: FirebaseAuth.instance.currentUser!.uid,
              date: DateTime.now(),
              matiereId: matiere.id,
              files: [],
            ),
            _uploadedFiles,
          ));

      _uploadedFiles.clear();
      _titleController.clear();
      _contentController.clear();
    }

    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        action: [
          IconButton(
            onPressed: () => _pickFiles(),
            icon: const Icon(Icons.attach_file),
          ),
          IconButton(
            onPressed: () => submitForm(),
            icon: const Icon(Icons.send),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: BlocListener<MatiereBloc, MatiereStates>(
        listener: (context, state) {
          if (state is DocAdding) {
            const Center(
              child: FadingCircleLoadingIndicator(),
            );
          }
          if (state is DocError) {
            Center(
              child: Text(
                state.message,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }
          if (state is DocAdded) {
            AppSnackBar.showTopSnackBar(
              context,
              'Doc added successfully',
              Colors.green,
            );
          }
        },
        child: Padding(
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
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'Enter the chapter title',
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  border: border,
                ),
                SizedBox(height: 16.h),

                // Content Text Field
                Text(
                  'Content',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
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
      ),
    );
  }
}
