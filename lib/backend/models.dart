// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  String? uid;
  String? name;
  String? course;
  String? branch;
  String? sem;
  String? mail;
  String? phone;
  String? unvRoll;
  String? desc;
  int? addmissionYear;
  String? imgUrl;
  Student({
    this.uid,
    this.name,
    this.course,
    this.branch,
    this.sem,
    this.mail,
    this.phone,
    this.unvRoll,
    this.desc,
    this.addmissionYear,
    this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'course': course,
      'branch': branch,
      'sem': sem,
      'mail': mail,
      'phone': phone,
      'unvRoll': unvRoll,
      'desc': desc,
      'addmissionYear': addmissionYear,
      'imgUrl': imgUrl,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      sem: map['sem'] != null ? map['sem'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      unvRoll: map['unvRoll'] != null ? map['unvRoll'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      addmissionYear:
          map['addmissionYear'] != null ? map['addmissionYear'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  Student copyWith({
    String? uid,
    String? name,
    String? course,
    String? branch,
    String? sem,
    String? mail,
    String? phone,
    String? unvRoll,
    String? desc,
    int? addmissionYear,
    String? imgUrl,
  }) {
    return Student(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      sem: sem ?? this.sem,
      mail: mail ?? this.mail,
      phone: phone ?? this.phone,
      unvRoll: unvRoll ?? this.unvRoll,
      desc: desc ?? this.desc,
      addmissionYear: addmissionYear ?? this.addmissionYear,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}

class Alumni {
  String? uid;
  String? name;
  String? course;
  String? branch;
  String? mail;
  String? phone;
  String? unvRoll;
  String? desc;
  int? addmissionYear;
  int? passoutYear;
  String? imgUrl;
  Map<String, dynamic>? exprience;

  Alumni({
    this.uid,
    this.name,
    this.course,
    this.branch,
    this.mail,
    this.phone,
    this.unvRoll,
    this.desc,
    this.addmissionYear,
    this.passoutYear,
    this.imgUrl,
    this.exprience,
  });

  Alumni copyWith({
    String? uid,
    String? name,
    String? course,
    String? branch,
    String? mail,
    String? phone,
    String? unvRoll,
    String? desc,
    int? addmissionYear,
    int? passoutYear,
    String? imgUrl,
    Map<String, dynamic>? exprience,
  }) {
    return Alumni(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      mail: mail ?? this.mail,
      phone: phone ?? this.phone,
      unvRoll: unvRoll ?? this.unvRoll,
      desc: desc ?? this.desc,
      addmissionYear: addmissionYear ?? this.addmissionYear,
      passoutYear: passoutYear ?? this.passoutYear,
      imgUrl: imgUrl ?? this.imgUrl,
      exprience: exprience ?? this.exprience,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'course': course,
      'branch': branch,
      'mail': mail,
      'phone': phone,
      'unvRoll': unvRoll,
      'desc': desc,
      'addmissionYear': addmissionYear,
      'passoutYear': passoutYear,
      'imgUrl': imgUrl,
      'exprience': exprience,
    };
  }

  factory Alumni.fromMap(Map<String, dynamic> map) {
    return Alumni(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      unvRoll: map['unvRoll'] != null ? map['unvRoll'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      addmissionYear:
          map['addmissionYear'] != null ? map['addmissionYear'] as int : null,
      passoutYear:
          map['passoutYear'] != null ? map['passoutYear'] as int : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      exprience: map['exprience'] != null
          ? Map<String, dynamic>.from(
              (map['exprience'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Alumni.fromJson(String source) =>
      Alumni.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Teacher {
  String? uid;
  String? name;
  String? course;
  String? branch;
  String? mail;
  String? subjects;
  String? phone;
  String? empID;
  String? desc;
  String? imgUrl;
  Map<String, dynamic>? exprience;
  Teacher({
    this.uid,
    this.name,
    this.course,
    this.branch,
    this.mail,
    this.subjects,
    this.phone,
    this.empID,
    this.desc,
    this.imgUrl,
    this.exprience,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'course': course,
      'branch': branch,
      'mail': mail,
      'subjects': subjects,
      'phone': phone,
      'empID': empID,
      'desc': desc,
      'imgUrl': imgUrl,
      'exprience': exprience,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      subjects: map['subjects'] != null ? map['subjects'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      empID: map['empID'] != null ? map['empID'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      exprience: map['exprience'] != null ? Map<String, dynamic>.from((map['exprience'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  Teacher copyWith({
    String? uid,
    String? name,
    String? course,
    String? branch,
    String? mail,
    String? subjects,
    String? phone,
    String? empID,
    String? desc,
    String? imgUrl,
    Map<String, dynamic>? exprience,
  }) {
    return Teacher(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      mail: mail ?? this.mail,
      subjects: subjects ?? this.subjects,
      phone: phone ?? this.phone,
      empID: empID ?? this.empID,
      desc: desc ?? this.desc,
      imgUrl: imgUrl ?? this.imgUrl,
      exprience: exprience ?? this.exprience,
    );
  }

  factory Teacher.fromJson(String source) => Teacher.fromMap(json.decode(source) as Map<String, dynamic>);
}
