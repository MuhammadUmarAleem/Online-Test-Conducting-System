import 'package:flutter/material.dart';
import 'package:quiz_hub/models/constants.dart';

class NavBar extends StatelessWidget {
   NavBar({super.key});

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text('example@gmail.com'),
            // currentAccountPicture: CircleAvatar(
            //   child: ClipOval(
            //     child: Image.network(
            //       'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
            //       fit: BoxFit.cover,
            //       width: 90,
            //       height: 90,
            //     ),
            //   ),
            // ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Image.asset("assets/icons/take_exam.png", color: Color(0xff8523D9),),
            title: Text('Access Exam', style: SideBarTextStyle,),
            onTap: () => null,
          ),
          ListTile(
            leading: Image.asset("assets/icons/exam-results.png", height: 30, color: Color(0xff8523D9),),
            title: Text('Get Result', style: SideBarTextStyle,),
            onTap: () => null,
          ),
          ListTile(
            leading: Image.asset("assets/icons/feedback.png", color: Color(0xff8523D9),),
            title: Text('Share Feedback', style: SideBarTextStyle),
            onTap: () => null,
          ),
          ListTile(
            leading: Image.asset("assets/icons/logout.png", color: Color(0xff8523D9),),
            title: Text('Logout', style: SideBarTextStyle,),
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(Icons.description),
          //   title: Text('Policies'),
          //   onTap: () => null,
          // ),
          // Divider(),
          // ListTile(
          //   title: Text('Exit'),
          //   leading: Icon(Icons.exit_to_app),
          //   onTap: () => null,
          // ),
        ],
      ),
    );
  }
}
