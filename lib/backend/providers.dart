import 'package:flutter/foundation.dart';
import 'package:gla_engage/backend/keywords.dart';
import 'package:gla_engage/backend/models.dart';

class UserProvider extends ChangeNotifier {
  late String _userType;

  String get getUserType => _userType;

  Alumni? _alumni;

  Student? _student;

  Teacher? _teacher;

  Alumni? get getAlumni => _alumni;

  Student? get getStudent => _student;

  Teacher? get getTeacher => _teacher;

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

  void setAlumni(Alumni alumni) {
    _alumni = alumni;
    notifyListeners();
  }

  void setStudent(Student student) {
    _student = student;
    notifyListeners();
  }

  void setTeacher(Teacher teacher) {
    _teacher = teacher;
    notifyListeners();
  }
}
