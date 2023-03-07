import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Student_Profile extends StatefulWidget {
  const Student_Profile({super.key});

  @override
  State<Student_Profile> createState() => _Student_ProfileState();
}

class _Student_ProfileState extends State<Student_Profile> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "white sneaker with adidas logo",
      "price": "255",
      "images":
          "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80",
    },
    {
      "title": "Black Jeans with blue stripes",
      "price": "245",
      "images":
          "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Red shoes with black stripes",
      "price": "155",
      "images":
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    },
    {
      "title": "Gamma shoes with beta brand.",
      "price": "275",
      "images":
          "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Alpha t-shirt for alpha testers.",
      "price": "25",
      "images":
          "https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Beta jeans for beta testers",
      "price": "27",
      "images":
          "https://images.unsplash.com/photo-1602293589930-45aad59ba3ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "V&V  model white t shirts.",
      "price": "55",
      "images":
          "https://images.unsplash.com/photo-1554568218-0f1715e72254?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    }
  ];

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
        Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade300,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
                color: Colors.green.shade100,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Column(
              children: [
                TopCompelete(),
                NameAndBio(),
                Social(),
                Logos(),
              ],
            )),
        Post(),
        Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.green.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade300,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ],
                shape: BoxShape.rectangle,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.green.shade300,
                    Colors.red,
                    Colors.indigo.shade300
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: PostContainer()),
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
                                  BorderRadius.all(Radius.circular(3)))),
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
                color: Colors.grey.shade500,
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text(
              Font,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      );

  Widget Logos() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 5),
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
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "POST",
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 400),
                    )
                  ],
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "SAVED",
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 400),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget PostContainer() {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: 310,
        ),
        itemCount: gridMap.length,
        itemBuilder: (_, index) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
                color: Colors.green.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      "${gridMap.elementAt(index)['images']}",
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${gridMap.elementAt(index)['title']}",
                          style: Theme.of(context).textTheme.subtitle1!.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.heart,
                              size: 17,
                              color: Colors.grey.shade500,
                            ),
                            Text(
                              "${gridMap.elementAt(index)['price']}",
                              style:
                                  Theme.of(context).textTheme.subtitle2!.merge(
                                        TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.heart,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.comment_bank_outlined,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
