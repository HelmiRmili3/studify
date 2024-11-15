import '../../../../../models/course.dart';
import '../../domain/repositories/etudiant_courses_repository.dart';
import '../datasources/local_courses_data_source.dart';
import '../datasources/remote_courses_data_source.dart';

class EtudiantCoursesRepositoryImpl implements EtudiantCoursesRepository {
  final RemoteCoursesDataSource remoteCoursesDataSource;
  final LocalCoursesDataSource localcoursesDataSource;
  EtudiantCoursesRepositoryImpl(
    this.remoteCoursesDataSource,
    this.localcoursesDataSource,
  );
  @override
  Stream<List<Course>> getAllCourses() {
    return remoteCoursesDataSource.getAllCourses();
  }

  @override
  Stream<Course> getCourse(String id) {
    return remoteCoursesDataSource.getCourse(id);
  }
}
