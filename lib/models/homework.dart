import 'file_item.dart';

class Homework {
  final String homeworkId; // Unique identifier for the homework
  final String title; // Title of the homework
  final String description; // Description of the homework
  final DateTime dueDate; // Due date for the homework
  final List<FileItem>
      homeworkFiles; // List of files associated with the homework

  Homework({
    required this.homeworkId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.homeworkFiles,
  });
}
