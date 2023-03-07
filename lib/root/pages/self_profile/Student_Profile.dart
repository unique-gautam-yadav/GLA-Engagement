import 'package:flutter/Material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Student_Profile extends StatefulWidget {
  const Student_Profile({super.key});

  @override
  State<Student_Profile> createState() => _Student_ProfileState();
}

class _Student_ProfileState extends State<Student_Profile> {
  // // Text Editing Forms For Validation
  // TextEditingController uid = TextEditingController();
  // TextEditingController name = TextEditingController();
  // TextEditingController course = TextEditingController();
  // TextEditingController branch = TextEditingController();
  // TextEditingController sem = TextEditingController();
  // TextEditingController mail = TextEditingController();
  // TextEditingController phone = TextEditingController();
  // TextEditingController unvRoll = TextEditingController();
  // TextEditingController desc = TextEditingController();
  // TextEditingController addmissionYear = TextEditingController();
  String? uid;
  String name = "Aditya Chauhan";
  String? course = "Diploma";
  String? branch = "CS";
  String? sem = "IV";
  String? mail = "adityachauhan123@gmail.com";
  String? phone = "8859835449";
  String? unvRoll = "2135000028";
  String? desc =
      "Make Coding as Your Passian You're Able To Solve Problems Easily . ";
  int? addmissionYear = 2021;
  final String CoverImageUrl =
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=MnwxfDB8MXxyYW5kb218MHx8bmF0dXJlP3JpdmVyP21vaW50YWluc3x8fHx8fDE2NzgwNDUxOTU&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=0';
  final String imgUrl =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=MnwxfDB8MXxyYW5kb218MHx8cHJvZmlsZXx8fHx8fDE2NzgwNTEwNjM&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1600';
  final double CoverImageHeight = 120;
  final double ProfileImageHeight = 130;

  @override
  Widget build(BuildContext context) {
    final top = CoverImageHeight - ProfileImageHeight / 2;
    return Container(
        child: Column(
      children: [
        TopCompelete(),
        NameAndBio(),
        Social(),
        Divider(
          indent: 10,
          endIndent: 20,
          color: Colors.grey.shade300,
          thickness: 1,
        ),
        Logos(),
        Divider(
          indent: 10,
          endIndent: 20,
          color: Colors.grey.shade300,
          thickness: 1,
        ),
        Post(),
      ],
    ));
  }

  Widget TopCompelete() {
    final top = CoverImageHeight - ProfileImageHeight / 2;
    final bottom = ProfileImageHeight / 2 - 35;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            padding: EdgeInsets.only(bottom: bottom), child: CoverImage()),
        Positioned(
          top: top,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ProfileImage(),
          ),
        ),
      ],
    );
  }

  Widget CoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          '$CoverImageUrl',
          width: double.infinity,
          height: CoverImageHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget ProfileImage() => Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircleAvatar(
          radius: 45,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: NetworkImage('$imgUrl'),
        ),
      );

  Widget NameAndBio() => Container(
        // height: 80,
        // width: double.infinity,
        padding: EdgeInsets.only(bottom: 15, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "$name  ",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.lock,
                  size: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: ElevatedButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(left: 25, right: 25)),
                      elevation: MaterialStateProperty.all(1),
                    ),
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Student At GLA University ",
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade300,
              ),

              // style:
              //     GoogleFonts.oswald(fontSize: 17, color: Colors.grey.shade300),
            ),
          ],
        ),
      );

  Widget Social() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BuildButton(Font: "POST", value: 3),
          Divider(height: 2),
          BuildButton(Font: "FOLLOWER", value: 1200),
          Divider(
            height: 2,
          ),
          BuildButton(Font: "FOLLOWING", value: 200),
        ],
      ),
    );
  }

  Widget BuildButton({required String Font, required int value}) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () => {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('$value',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text(
              Font,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      );

  Widget Logos() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/images/github.svg",
            height: 40,
            width: 40,
          ),
          SvgPicture.asset(
            "assets/images/linkedin.svg",
            height: 40,
            width: 40,
          ),
          SvgPicture.asset(
            "assets/images/twitter.svg",
            height: 40,
            width: 40,
          ),
          SvgPicture.asset(
            "assets/images/instagram.svg",
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }

  Widget Post() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "POST",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  "SAVED",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            )
          ],
        ),
      ),
    );
  }
}
