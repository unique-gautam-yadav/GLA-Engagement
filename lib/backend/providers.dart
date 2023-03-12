import 'package:flutter/foundation.dart';
import 'package:gla_engage/backend/keywords.dart';
import 'package:gla_engage/backend/models.dart';

class UserProvider extends ChangeNotifier {
  late String _userType;

  String get getUserType => _userType;

  AlumniModel? _alumni;

  StudentModel? _student;

  TeacherModel? _teacher;

  AlumniModel? get getAlumni => _alumni;

  StudentModel? get getStudent => _student;

  TeacherModel? get getTeacher => _teacher;

  ProfileModel? get getProfile {
    if (_userType == KeyWords.alumniUser) {
      return ProfileModel.fromMap(_alumni!.toMap());
    } else if (_userType == KeyWords.studentUser) {
      return ProfileModel.fromMap(_student!.toMap());
    } else if (_userType == KeyWords.teacherUser) {
      return ProfileModel.fromMap(_teacher!.toMap());
    } else {
      return null;
    }
  }

  Map<String, dynamic>? get userToMap {
    if (_userType == KeyWords.alumniUser) {
      return _alumni!.toMap();
    } else if (_userType == KeyWords.studentUser) {
      return _student!.toMap();
    } else if (_userType == KeyWords.teacherUser) {
      return _teacher!.toMap();
    }
    return {};
  }

  void setUserType(String userType) {
    _userType = userType;
    notifyListeners();
  }

  void setAlumni(AlumniModel alumni) {
    _alumni = alumni;
    notifyListeners();
  }

  void setStudent(StudentModel student) {
    _student = student;
    notifyListeners();
  }

  void setTeacher(TeacherModel teacher) {
    _teacher = teacher;
    notifyListeners();
  }
}
