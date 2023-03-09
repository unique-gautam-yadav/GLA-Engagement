// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  String? type;
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
  String? coverImage;
  Student({
    this.type,
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
    this.coverImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
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
      'coverImage': coverImage,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      type: map['type'] != null ? map['type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      sem: map['sem'] != null ? map['sem'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      unvRoll: map['unvRoll'] != null ? map['unvRoll'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      addmissionYear:
          map['addmissionYear'] != null ? map['addmissionYear'] as int : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      coverImage:
          map['coverImage'] != null ? map['coverImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  Student copyWith({
    String? type,
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
    String? coverImage,
  }) {
    return Student(
      type: type ?? this.type,
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
      coverImage: coverImage ?? this.coverImage,
    );
  }

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Alumni {
  String? type;
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
  String? coverImage;
  Map<String, dynamic>? exprience;

  Alumni({
    this.type,
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
    this.coverImage,
    this.exprience,
  });

  Alumni copyWith({
    String? type,
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
    String? coverImage,
    Map<String, dynamic>? exprience,
  }) {
    return Alumni(
      type: type ?? this.type,
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
      coverImage: coverImage ?? this.coverImage,
      exprience: exprience ?? this.exprience,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
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
      'coverImage': coverImage,
      'exprience': exprience,
    };
  }

  factory Alumni.fromMap(Map<String, dynamic> map) {
    return Alumni(
      type: map['type'] != null ? map['type'] as String : null,
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
      coverImage:
          map['coverImage'] != null ? map['coverImage'] as String : null,
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
  String? type;
  String? name;
  String? course;
  String? branch;
  String? mail;
  String? phone;
  String? subjects;
  String? empID;
  String? desc;
  String? imgUrl;
  String? coverImage;
  Map<String, dynamic>? exprience;
  Teacher({
    this.type,
    this.name,
    this.course,
    this.branch,
    this.mail,
    this.subjects,
    this.phone,
    this.empID,
    this.desc,
    this.imgUrl,
    this.coverImage,
    this.exprience,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'course': course,
      'branch': branch,
      'mail': mail,
      'subjects': subjects,
      'phone': phone,
      'empID': empID,
      'desc': desc,
      'imgUrl': imgUrl,
      'coverImage': coverImage,
      'exprience': exprience,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      type: map['type'] != null ? map['type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      subjects: map['subjects'] != null ? map['subjects'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      empID: map['empID'] != null ? map['empID'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      coverImage:
          map['coverImage'] != null ? map['coverImage'] as String : null,
      exprience: map['exprience'] != null
          ? Map<String, dynamic>.from(
              (map['exprience'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  Teacher copyWith({
    String? type,
    String? name,
    String? course,
    String? branch,
    String? mail,
    String? subjects,
    String? phone,
    String? empID,
    String? desc,
    String? imgUrl,
    String? coverImage,
    Map<String, dynamic>? exprience,
  }) {
    return Teacher(
      type: type ?? this.type,
      name: name ?? this.name,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      mail: mail ?? this.mail,
      subjects: subjects ?? this.subjects,
      phone: phone ?? this.phone,
      empID: empID ?? this.empID,
      desc: desc ?? this.desc,
      imgUrl: imgUrl ?? this.imgUrl,
      coverImage: coverImage ?? this.coverImage,
      exprience: exprience ?? this.exprience,
    );
  }

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProfileModel {
  String? type;
  String? name;
  String? course;
  String? branch;
  String? sem;
  String? mail;
  String? phone;
  String? unvRoll;
  String? desc;
  int? addmissionYear;
  int? passoutYear;
  String? coverImage;
  String? imgUrl;
  String? empID;
  String? subjects;
  Map<String, dynamic>? exprience;
  ProfileModel({
    this.type,
    this.name,
    this.course,
    this.branch,
    this.sem,
    this.mail,
    this.phone,
    this.unvRoll,
    this.desc,
    this.addmissionYear,
    this.passoutYear,
    this.coverImage,
    this.imgUrl,
    this.empID,
    this.subjects,
    this.exprience,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'course': course,
      'branch': branch,
      'sem': sem,
      'mail': mail,
      'phone': phone,
      'unvRoll': unvRoll,
      'desc': desc,
      'addmissionYear': addmissionYear,
      'passoutYear': passoutYear,
      'coverImage': coverImage,
      'imgUrl': imgUrl,
      'empID': empID,
      'subjects': subjects,
      'exprience': exprience,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      type: map['type'] != null ? map['type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      sem: map['sem'] != null ? map['sem'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      unvRoll: map['unvRoll'] != null ? map['unvRoll'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      addmissionYear:
          map['addmissionYear'] != null ? map['addmissionYear'] as int : null,
      passoutYear:
          map['passoutYear'] != null ? map['passoutYear'] as int : null,
      coverImage:
          map['coverImage'] != null ? map['coverImage'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      empID: map['empID'] != null ? map['empID'] as String : null,
      subjects: map['subjects'] != null ? map['subjects'] as String : null,
      exprience: map['exprience'] != null
          ? Map<String, dynamic>.from(
              (map['exprience'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProfileModel copyWith({
    String? type,
    String? name,
    String? course,
    String? branch,
    String? sem,
    String? mail,
    String? phone,
    String? unvRoll,
    String? desc,
    int? addmissionYear,
    int? passoutYear,
    String? coverImage,
    String? imgUrl,
    String? empID,
    String? subjects,
    Map<String, dynamic>? exprience,
  }) {
    return ProfileModel(
      type: type ?? this.type,
      name: name ?? this.name,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      sem: sem ?? this.sem,
      mail: mail ?? this.mail,
      phone: phone ?? this.phone,
      unvRoll: unvRoll ?? this.unvRoll,
      desc: desc ?? this.desc,
      addmissionYear: addmissionYear ?? this.addmissionYear,
      passoutYear: passoutYear ?? this.passoutYear,
      coverImage: coverImage ?? this.coverImage,
      imgUrl: imgUrl ?? this.imgUrl,
      empID: empID ?? this.empID,
      subjects: subjects ?? this.subjects,
      exprience: exprience ?? this.exprience,
    );
  }
}
