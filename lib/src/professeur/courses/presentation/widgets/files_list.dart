import 'dart:typed_data';
import 'dart:io';

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

        try {
          if (['jpg', 'jpeg', 'png', 'gif'].contains(file.extension)) {
            Uint8List imageData = File(file.path!).readAsBytesSync();

            leadingWidget = ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
              child: Image.memory(
                imageData,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            );
          } else {
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

            leadingWidget = Container(
              width: 80.w,
              height: 80.h,
              alignment: Alignment.center,
              child: Icon(
                fileIcon,
                size: 32.sp,
                color: Colors.blueAccent,
              ),
            );
          }
        } catch (e) {
          leadingWidget = Container(
            width: 100.w,
            height: 100.h,
            alignment: Alignment.center,
            child: Icon(
              Icons.error,
              size: 32.sp,
              color: Colors.redAccent,
            ),
          );
        }

        return Card(
          shadowColor: Colors.blue.withOpacity(0.1),
          surfaceTintColor: Colors.blue.withOpacity(0.1),
          borderOnForeground: false,
          semanticContainer: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingWidget,
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${(file.size / 1024).toStringAsFixed(2)} KB',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 24.sp,
                ),
                onPressed: () => onRemoveFile(file),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
