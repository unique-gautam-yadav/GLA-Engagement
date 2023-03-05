import 'package:flutter/Material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Student_Profile extends StatefulWidget {
  const Student_Profile({super.key});

  @override
  State<Student_Profile> createState() => _Student_ProfileState();
}

class _Student_ProfileState extends State<Student_Profile> {
  final double CoverImageHeight = 280;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
         child: Stack( 
          alignment : Alignment.center,
            children: [
               CoverImage(),
               ProfileImage(),
            ],
        )
      ),
    );
  }
  Widget CoverImage() => Container(
    color: Colors.grey,
    child: SvgPicture.asset('assets/images/Profile-Cover.svg', width: double.infinity,
    height: CoverImageHeight,
    fit: BoxFit.cover,),
  );

    Widget ProfileImage() => Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 95,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/Images/profile.png")),
           ),
      );
}