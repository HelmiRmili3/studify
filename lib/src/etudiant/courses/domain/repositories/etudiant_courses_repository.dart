import '../../../../../models/course.dart';

abstract class EtudiantCoursesRepository {
  Stream<List<Course>> getAllCourses();
  Stream<Course> getCourse(String id);
}
