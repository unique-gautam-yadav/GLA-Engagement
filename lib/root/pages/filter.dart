import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class filter extends StatelessWidget {
  const filter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    "Filter",
                    style: TextStyle(fontSize: 25, color: Colors.grey.shade700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 13),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontSize: 22, color: Colors.grey.shade700),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "User Type",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    width: 125,
                    child: MaterialButton(
                      onPressed: () {
                        // UserBanner();
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Icon(CupertinoIcons.arrow_right),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
