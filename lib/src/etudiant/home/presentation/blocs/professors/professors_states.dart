import '../../../../../../models/user.dart';

abstract class ProfessorsStates {}

class ProfessorsInitial extends ProfessorsStates {}

class LoadingProfessors extends ProfessorsStates {}

class ProfessorsLoaded extends ProfessorsStates {
  List<UserModel> professors;
  ProfessorsLoaded(this.professors);
}

class ErrorProfessors extends ProfessorsStates {
  final String message;
  ErrorProfessors(this.message);
}
