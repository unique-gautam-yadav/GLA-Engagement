import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KeyWords {
  static const String studentUser = "student";
  static const String alumniUser = "alumni";
  static const String teacherUser = "teacher";
}
 
class SocialMeda {
  static List<String> socialLinks = [
    "instagram",
    "stackoverflow",
    "github",
    "youtube",
    "linkedin",
    "twitter",
    // "pinterest",
    "facebook",
  ];
  static Widget? getIcon(String url) {
    for (var e in socialLinks) {
      if (url.toLowerCase().contains(e)) {
        return SvgPicture.asset("assets/svgs/$e.svg");
      }
    }
    return const Icon(Icons.link);
  }
}
