import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/accessExam.dart';
import 'package:quiz_hub/FrontEnd/Student/getResult.dart';
import 'package:quiz_hub/FrontEnd/Student/getTeacherFeedback.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/loginResponse.dart';

class NavBar extends StatefulWidget {
   NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Constants constants = Constants();

  localStorage localUser = localStorage();

  // Function to show logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout logic here
                Navigator.of(context).pop(); // Close the dialog
                // Add your logout code here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
      return Drawer(
        child: FutureBuilder(
          future: localStorage().getUser(),
          builder: (context, snap){
          if(snap.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
              ),
            );
          }
          else {
            return ListView(
              // Remove padding
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(snap.data!.rollNo.toString()),
                  accountEmail: Text(snap.data!.email.toString()),

                  decoration:const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                ),
                ListTile(
                  leading: Image.asset("assets/icons/take_exam.png",
                    color: const Color(0xff8523D9),),
                  title: const Text('Access Exam', style: SideBarTextStyle,),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccessExam(),
                    ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/icons/exam-results.png", height: 30,
                    color: const Color(0xff8523D9),),
                  title: const Text('Get Result', style: SideBarTextStyle,),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GetResult(),
                    ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset("assets/icons/feedback.png",
                    color: const Color(0xff8523D9),),
                  title: const Text('Teacher Feedback', style: SideBarTextStyle),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GetTeacherFeedback()));
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/icons/logout.png", color: const Color(0xff8523D9),),
                  title: const Text('Logout', style: SideBarTextStyle,),
                  onTap: (){
                    _showLogoutConfirmationDialog();
                  },
                ),
              ],
            );
          }
          })
    );
  }
}
