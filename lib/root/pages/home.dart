import 'package:flutter/material.dart';

import 'main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // appBar: AppBar(
        //   title: Text("App Ka NAme"),
        //   elevation: 2.0,
        //   centerTitle: true,
        //   actions: [
        //     IconButton(onPressed: () {}, icon: Icon(Icons.search_sharp)),
        //     PopupMenuButton<int>(
        //         // icon: Icon(Icons.),
        //         itemBuilder: (context) => [
        //               const PopupMenuItem(
        //                 value: 1,
        //                 child: Text("Get The App"),
        //               ),
        //               PopupMenuItem(
        //                 child: Text("chbdscv"),
        //                 value: 2,
        //               ),
        //             ]),
        //   ],
        // ),
        // body:
        Container(
      child: Text("hello every one"),
    );
    // bottomNavigationBar: NavBarView(),
    // );
  }
}
