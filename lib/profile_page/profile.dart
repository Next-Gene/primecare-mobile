import 'package:flutter/material.dart';
import 'package:nexgen/Component/profile_component.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile_page> {
  // حجز متغير الحالة للسويتش
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Container(
                  width: 305,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Color(0xFF79CCFF),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(2, 3),
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            "Assets/hazem.jpg",
                            fit: BoxFit.cover,
                            width: 55,
                            height: 55,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Mohamed hazem",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "@ENG HAZEM",
                              style: TextStyle(
                                color: Color(0xFF00006B),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: ImageIcon(
                            AssetImage("Assets/Edit.png"),
                            size: 24,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            
            ProfileOptionTile(
              title: "My Account",
              subtitle: "Make Changes in your information",
              imagePath: "Assets/user.png",
              onTap: () {},
              icon: Icons.keyboard_arrow_right,
            ),

            ProfileOptionTile(
              title: "Saved Account",
              subtitle: "Manage your accounts",
              imagePath: "Assets/user.png",
              onTap: () {},
              icon: Icons.keyboard_arrow_right,
            ),

            ProfileOptionTile(
              title: "Face id/ Touch id",
              subtitle: "Make your Device security",
              imagePath: "Assets/lock_profile.png",
              onTap: () {},
              isSwitched: isSwitched,
              onSwitchChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            ProfileOptionTile(
              title: "Logout",
              subtitle: "Logout from your account",
              imagePath: "Assets/exit_profile.png",
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
              child: Row(
                children: [
                  Text(
                    "More",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black45
                  ),
                  ),
                ],
              ),
            ),
            ProfileOptionTile(
              title: "Logout",
              subtitle: "Logout from your account",
              imagePath: "Assets/setting.png",
              onTap: () {},
              icon: Icons.keyboard_arrow_right,
            ),
            ProfileOptionTile(
              title: "Logout",
              subtitle: "Logout from your account",
              imagePath: "Assets/bell.png",
              onTap: () {},
              icon: Icons.keyboard_arrow_right,
            ),
            ProfileOptionTile(
              title: "Logout",
              subtitle: "Logout from your account",
              imagePath: "Assets/heart.png",
              onTap: () {},
              icon: Icons.keyboard_arrow_right,
            ),
          ],
        ),
      ),
    );
  }
}









/*
  Padding(
              padding: const EdgeInsets.only(right: 20,left: 20,top: 25),
              child: Container(
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    Container(
                      width: 41,
                      height: 41,
                      decoration: BoxDecoration(
                          color: Color(0xFF86D1FF),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child:  Image.asset(
                          "Assets/user.png",
                          fit: BoxFit.fill,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Account",
                            style:TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13
                          ),
                          ),
                          Text(
                            "Make changes in yor information",
                            style:TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Color(0xFF00006E)
                          ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_right))
                  ],
                ),
              ),
            )
 */



//Profile_page