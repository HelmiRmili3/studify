import '../../../../../models/course.dart';

abstract class RemoteCoursesDataSource {
  Stream<List<Course>> getAllCourses();
  Stream<Course> getCourse(String id);
}

class RemoteCoursesDataSourceImpl implements RemoteCoursesDataSource {
  @override
  Stream<List<Course>> getAllCourses() {
    throw UnimplementedError();
  }

  @override
  Stream<Course> getCourse(String id) {
    throw UnimplementedError();
  }
}
