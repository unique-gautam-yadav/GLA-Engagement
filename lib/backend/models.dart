// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
  List<Map<String, dynamic>>? skills;
  List<String>? keywords;
  String? token;
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
    this.skills,
    this.keywords,
    this.token,
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
      'skills': skills,
      'keywords': keywords,
      'token': token,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      token: map['token'] != null ? map['token'] as String : null,
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
      skills: map['skills'] != null
          ? List<Map<String, dynamic>>.from(
              (map['skills'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      keywords: map['keywords'] != null
          ? List<String>.from(
              (map['keywords'] as List<dynamic>).map<String?>(
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
    List<Map<String, dynamic>>? skills,
    List<String>? keywords,
    String? token,
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
      skills: skills ?? this.skills,
      keywords: keywords ?? this.keywords,
      token: token ?? this.token,
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
  List<Map<String, dynamic>>? skills;
  List<String>? keywords;
  String? token;
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
    this.skills,
    this.keywords,
    this.token,
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
      'skills': skills,
      'token': token,
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
      socialLinks: map['socialLinks'] != null
          ? List<Map<String, dynamic>>.from(
              (map['socialLinks'] as List<dynamic>).map<Map<String, dynamic>?>(
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
      skills: map['skills'] != null
          ? List<Map<String, dynamic>>.from(
              (map['skills'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      keywords: map['keywords'] != null
          ? List<String>.from(
              (map['keywords'] as List<dynamic>).map<String?>(
                (x) => x,
              ),
            )
          : null,
      token: map['token'] != null ? map['token'] as String : null,
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
    List<Map<String, dynamic>>? skills,
    List<String>? keywords,
    String? token,
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
      skills: skills ?? this.skills,
      keywords: keywords ?? this.keywords,
      token: token ?? this.token,
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
  List<Map<String, dynamic>>? skills;
  List<String>? keywords;
  String? token;
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
    this.skills,
    this.keywords,
    this.token,
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
      'skills': skills,
      'keywords': keywords,
      'token': token,
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
      socialLinks: map['socialLinks'] != null
          ? List<Map<String, dynamic>>.from(
              (map['socialLinks'] as List<dynamic>).map<Map<String, dynamic>?>(
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
      skills: map['skills'] != null
          ? List<Map<String, dynamic>>.from(
              (map['skills'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      keywords: map['keywords'] != null
          ? List<String>.from(
              (map['keywords'] as List<dynamic>).map<String?>(
                (x) => x,
              ),
            )
          : null,
      token: map['token'] != null ? map['token'] as String : null,
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
    List<Map<String, dynamic>>? skills,
    List<String>? keywords,
    String? token,
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
      skills: skills ?? this.skills,
      keywords: keywords ?? this.keywords,
      token: token ?? this.token,
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
  List<Map<String, dynamic>>? skills;
  List<String>? keywords;
  String? token;
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
    this.skills,
    this.keywords,
    this.token,
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
      'skills': skills,
      'keywords': keywords,
      'token': token,
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
      socialLinks: map['socialLinks'] != null
          ? List<Map<String, dynamic>>.from(
              (map['socialLinks'] as List<dynamic>).map<Map<String, dynamic>?>(
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
      skills: map['skills'] != null
          ? List<Map<String, dynamic>>.from(
              (map['skills'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      subjects: map['subjects'] != null
          ? List<Map<String, dynamic>>.from(
              (map['subjects'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      keywords: map['keywords'] != null
          ? List<String>.from(
              (map['keywords'] as List<dynamic>).map<String?>(
                (x) => x,
              ),
            )
          : null,
      token: map['token'] != null ? map['token'] as String : null,
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
    List<Map<String, dynamic>>? skills,
    List<String>? keywords,
    String? token,
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
      skills: skills ?? this.skills,
      keywords: keywords ?? this.keywords,
      token: token ?? this.token,
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
      likes: map['likes'] != null
          ? List<String>.from((map['likes'] as List<dynamic>))
          : null,
      timeStamp: map['timeStamp'] != null ? map['timeStamp'] as String : null,
      postedBy: map['postedBy'] != null ? map['postedBy'] as String : null,
      caption: map['caption'] != null ? map['caption'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

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

class HomePagePosts {
  PostModel? post;
  ProfileModel? profile;
  HomePagePosts({
    this.post,
    this.profile,
  });
}

class ChatRoomModel {
  String? chatroomid;
  String? lastmessage;
  Map<String, dynamic>? participants;
  List<String>? users;
  String? lastActive;
  ChatRoomModel(
      {this.chatroomid,
      this.lastmessage,
      this.participants,
      this.users,
      this.lastActive});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatroomid': chatroomid,
      'lastmessage': lastmessage,
      'participants': participants,
      'users': users,
      'lastActive': lastActive,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatroomid:
          map['chatroomid'] != null ? map['chatroomid'] as String : null,
      lastmessage:
          map['lastmessage'] != null ? map['lastmessage'] as String : null,
      participants: map['participants'] != null
          ? Map<String, dynamic>.from(
              (map['participants'] as Map<String, dynamic>))
          : null,
      users: map['users'] != null
          ? List<String>.from((map['users'] as List<dynamic>))
          : null,
      lastActive:
          map['lastActive'] != null ? map['lastActive'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ChatRoomModel copyWith({
    String? chatroomid,
    String? lastmessage,
    Map<String, dynamic>? participants,
    List<String>? users,
    String? lastActive,
  }) {
    return ChatRoomModel(
      chatroomid: chatroomid ?? this.chatroomid,
      lastmessage: lastmessage ?? this.lastmessage,
      participants: participants ?? this.participants,
      users: users ?? this.users,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}

class ChatModel {
  String? sender;
  String? message;
  DateTime? timeStamp;
  ChatModel({
    this.sender,
    this.message,
    this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'message': message,
      'timeStamp': timeStamp?.millisecondsSinceEpoch,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      sender: map['sender'] != null ? map['sender'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      timeStamp: map['timeStamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeStamp'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ChatModel copyWith({
    String? sender,
    String? message,
    DateTime? timeStamp,
  }) {
    return ChatModel(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}

class UserDetails {
  List<String>? followers;
  List<String>? following;
  UserDetails({
    this.followers,
    this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'followers': followers,
      'following': following,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      followers: map['followers'] != null
          ? List<String>.from((map['followers'] as List<dynamic>))
          : null,
      following: map['following'] != null
          ? List<String>.from((map['following'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  UserDetails copyWith({
    List<String>? followers,
    List<String>? following,
  }) {
    return UserDetails(
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}

class SkillModel {
  String? title;
  String? description;
  String? level;
  SkillModel({
    this.title,
    this.description,
    this.level,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'level': level,
    };
  }

  factory SkillModel.fromMap(Map<String, dynamic> map) {
    return SkillModel(
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      level: map['level'] != null ? map['level'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SkillModel.fromJson(String source) =>
      SkillModel.fromMap(json.decode(source) as Map<String, dynamic>);

  SkillModel copyWith({
    String? title,
    String? description,
    String? level,
  }) {
    return SkillModel(
      title: title ?? this.title,
      description: description ?? this.description,
      level: level ?? this.level,
    );
  }
}

class Freelancing {
  List<String>? skill;
  String? duration;
  String? package;
  String? decp;
  Freelancing({
    this.skill,
    this.duration,
    this.package,
    this.decp,
  });

  Freelancing copyWith({
    List<String>? skill,
    String? duration,
    String? package,
    String? decp,
  }) {
    return Freelancing(
      skill: skill ?? this.skill,
      duration: duration ?? this.duration,
      package: package ?? this.package,
      decp: decp ?? this.decp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'skill': skill,
      'duration': duration,
      'package': package,
      'decp': decp,
    };
  }

  factory Freelancing.fromMap(Map<String, dynamic> map) {
    return Freelancing(
      skill: map['skill'] != null
          ? List<String>.from((map['skill'] as List<String>))
          : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
      package: map['package'] != null ? map['package'] as String : null,
      decp: map['decp'] != null ? map['decp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Freelancing.fromJson(String source) =>
      Freelancing.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Freelancing(skill: $skill, duration: $duration, package: $package, decp: $decp)';
  }

  @override
  bool operator ==(covariant Freelancing other) {
    if (identical(this, other)) return true;

    return listEquals(other.skill, skill) &&
        other.duration == duration &&
        other.package == package &&
        other.decp == decp;
  }

  @override
  int get hashCode {
    return skill.hashCode ^
        duration.hashCode ^
        package.hashCode ^
        decp.hashCode;
  }
}
