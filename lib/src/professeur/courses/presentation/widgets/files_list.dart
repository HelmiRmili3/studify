import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileList extends StatelessWidget {
  final List<PlatformFile> uploadedFiles;
  final Function(PlatformFile file) onRemoveFile;

  const FileList({
    super.key,
    required this.uploadedFiles,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: uploadedFiles.map((file) {
        Widget leadingWidget;

        // Check if the file is an image and display it
        if (['jpg', 'jpeg', 'png', 'gif'].contains(file.extension)) {
          leadingWidget = ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              'assets/images/default_avatar.png',
              width: 50.w,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        } else {
          // Use file type icons for non-image files
          IconData fileIcon;
          if (file.extension == 'pdf') {
            fileIcon = Icons.picture_as_pdf;
          } else if (['doc', 'docx'].contains(file.extension)) {
            fileIcon = Icons.description;
          } else if (file.extension == 'zip') {
            fileIcon = Icons.folder_zip;
          } else {
            fileIcon = Icons.insert_drive_file;
          }

          leadingWidget = Icon(
            fileIcon,
            size: 32.sp,
            color: Colors.blueAccent,
          );
        }

        return Card(
          // color: Colors.blue.withOpacity(.1),
          shadowColor: Colors.blue.withOpacity(.1),
          surfaceTintColor: Colors.blue.withOpacity(.1),
          borderOnForeground: false,
          semanticContainer: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.symmetric(vertical: 8.h),
          child: ListTile(
            leading: leadingWidget,
            title: Text(
              file.name,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              '${(file.size / 1024).toStringAsFixed(2)} KB',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 24.sp,
              ),
              onPressed: () => onRemoveFile(file),
            ),
          ),
        );
      }).toList(),
    );
  }
}
