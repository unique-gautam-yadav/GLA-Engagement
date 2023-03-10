// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentModel {
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
  List<Map<String, dynamic>>? achievements;
  List<Map<String, dynamic>>? socialLinks;
  StudentModel({
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
    this.achievements,
    this.socialLinks,
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
      'achievements': achievements,
      'socialLinks': socialLinks,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
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
      achievements: map['achievements'] != null
          ? List<Map<String, dynamic>>.from(
              (map['achievements'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      socialLinks: map['socialLinks'] != null
          ? List<Map<String, dynamic>>.from(
              (map['socialLinks'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  StudentModel copyWith({
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
    List<Map<String, dynamic>>? achievements,
    List<Map<String, dynamic>>? socialLinks,
  }) {
    return StudentModel(
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
      achievements: achievements ?? this.achievements,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }
}

class AlumniModel {
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
  List<Map<String, dynamic>>? achievements;
  List<Map<String, dynamic>>? socialLinks;
  AlumniModel({
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
    this.achievements,
    this.socialLinks,
  });

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
      'achievements': achievements,
      'socialLinks': socialLinks,
    };
  }

  factory AlumniModel.fromMap(Map<String, dynamic> map) {
    return AlumniModel(
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
      achievements: map['achievements'] != null
          ? List<Map<String, dynamic>>.from(
              (map['achievements'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      socialLinks: map['socialLinks'] != null
          ? List<Map<String, dynamic>>.from(
              (map['socialLinks'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlumniModel.fromJson(String source) =>
      AlumniModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AlumniModel copyWith({
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
    List<Map<String, dynamic>>? achievements,
    List<Map<String, dynamic>>? socialLinks,
  }) {
    return AlumniModel(
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
      achievements: achievements ?? this.achievements,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }
}

class TeacherModel {
  String? type;
  String? name;
  String? course;
  String? branch;
  String? mail;
  String? phone;
  List<Map<String, dynamic>>? subjects;
  String? empID;
  String? desc;
  String? imgUrl;
  String? coverImage;
  List<Map<String, dynamic>>? achievements;
  List<Map<String, dynamic>>? socialLinks;
  TeacherModel({
    this.type,
    this.name,
    this.course,
    this.branch,
    this.mail,
    this.phone,
    this.subjects,
    this.empID,
    this.desc,
    this.imgUrl,
    this.coverImage,
    this.achievements,
    this.socialLinks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'course': course,
      'branch': branch,
      'mail': mail,
      'phone': phone,
      'subjects': subjects,
      'empID': empID,
      'desc': desc,
      'imgUrl': imgUrl,
      'coverImage': coverImage,
      'achievements': achievements,
      'socialLinks': socialLinks,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      type: map['type'] != null ? map['type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      subjects: map['subjects'] != null
          ? List<Map<String, dynamic>>.from(
              (map['subjects'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      empID: map['empID'] != null ? map['empID'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      coverImage:
          map['coverImage'] != null ? map['coverImage'] as String : null,
      achievements: map['achievements'] != null
          ? List<Map<String, dynamic>>.from(
              (map['achievements'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      socialLinks: map['socialLinks'] != null
          ? List<Map<String, dynamic>>.from(
              (map['socialLinks'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TeacherModel copyWith({
    String? type,
    String? name,
    String? course,
    String? branch,
    String? mail,
    String? phone,
    List<Map<String, dynamic>>? subjects,
    String? empID,
    String? desc,
    String? imgUrl,
    String? coverImage,
    List<Map<String, dynamic>>? achievements,
    List<Map<String, dynamic>>? socialLinks,
  }) {
    return TeacherModel(
      type: type ?? this.type,
      name: name ?? this.name,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      mail: mail ?? this.mail,
      phone: phone ?? this.phone,
      subjects: subjects ?? this.subjects,
      empID: empID ?? this.empID,
      desc: desc ?? this.desc,
      imgUrl: imgUrl ?? this.imgUrl,
      coverImage: coverImage ?? this.coverImage,
      achievements: achievements ?? this.achievements,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }
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
  List<Map<String, dynamic>>? subjects;
  List<Map<String, dynamic>>? achievements;
  List<Map<String, dynamic>>? socialLinks;
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
    this.achievements,
    this.socialLinks,
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
      'achievements': achievements,
      'socialLinks': socialLinks,
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
      subjects: map['subjects'] != null
          ? List<Map<String, dynamic>>.from(
              (map['subjects'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      achievements: map['achievements'] != null
          ? List<Map<String, dynamic>>.from(
              (map['achievements'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      socialLinks: map['socialLinks'] != null
          ? List<Map<String, dynamic>>.from(
              (map['socialLinks'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
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
    List<Map<String, dynamic>>? subjects,
    List<Map<String, dynamic>>? achievements,
    List<Map<String, dynamic>>? socialLinks,
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
      achievements: achievements ?? this.achievements,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }
}

class SocialLinkModel {
  String? title;
  String? url;
  String? wesiteName;
  SocialLinkModel({
    this.title,
    this.url,
    this.wesiteName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'wesiteName': wesiteName,
    };
  }

  factory SocialLinkModel.fromMap(Map<String, dynamic> map) {
    return SocialLinkModel(
      title: map['title'] != null ? map['title'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      wesiteName:
          map['wesiteName'] != null ? map['wesiteName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialLinkModel.fromJson(String source) =>
      SocialLinkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  SocialLinkModel copyWith({
    String? title,
    String? url,
    String? wesiteName,
  }) {
    return SocialLinkModel(
      title: title ?? this.title,
      url: url ?? this.url,
      wesiteName: wesiteName ?? this.wesiteName,
    );
  }
}

class AchievementModel {
  String? title;
  String? briefDesc;
  String? detaiedDesc;
  AchievementModel({
    this.title,
    this.briefDesc,
    this.detaiedDesc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'briefDesc': briefDesc,
      'detaiedDesc': detaiedDesc,
    };
  }

  factory AchievementModel.fromMap(Map<String, dynamic> map) {
    return AchievementModel(
      title: map['title'] != null ? map['title'] as String : null,
      briefDesc: map['briefDesc'] != null ? map['briefDesc'] as String : null,
      detaiedDesc:
          map['detaiedDesc'] != null ? map['detaiedDesc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AchievementModel.fromJson(String source) =>
      AchievementModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AchievementModel copyWith({
    String? title,
    String? briefDesc,
    String? detaiedDesc,
  }) {
    return AchievementModel(
      title: title ?? this.title,
      briefDesc: briefDesc ?? this.briefDesc,
      detaiedDesc: detaiedDesc ?? this.detaiedDesc,
    );
  }
}

class PostModel {
  String? postID;
  String? imgUrl;
  List<String>? likes;
  String? timeStamp;
  String? postedBy;
  String? caption;
  PostModel({
    this.postID,
    this.imgUrl,
    this.likes,
    this.timeStamp,
    this.postedBy,
    this.caption,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postID': postID,
      'imgUrl': imgUrl,
      'likes': likes,
      'timeStamp': timeStamp,
      'postedBy': postedBy,
      'caption': caption,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postID: map['postID'] != null ? map['postID'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      likes: map['likes'] != null ? List<String>.from((map['likes'] as List<String>)) : null,
      timeStamp: map['timeStamp'] != null ? map['timeStamp'] as String : null,
      postedBy: map['postedBy'] != null ? map['postedBy'] as String : null,
      caption: map['caption'] != null ? map['caption'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    String? postID,
    String? imgUrl,
    List<String>? likes,
    String? timeStamp,
    String? postedBy,
    String? caption,
  }) {
    return PostModel(
      postID: postID ?? this.postID,
      imgUrl: imgUrl ?? this.imgUrl,
      likes: likes ?? this.likes,
      timeStamp: timeStamp ?? this.timeStamp,
      postedBy: postedBy ?? this.postedBy,
      caption: caption ?? this.caption,
    );
  }
}
