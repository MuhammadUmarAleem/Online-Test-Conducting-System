import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Teacher/createExam.dart';
import 'package:quiz_hub/FrontEnd/Teacher/reviewResults.dart';
import 'package:quiz_hub/FrontEnd/Teacher/teacherFeedback.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/models/constants.dart';
import '../localStorage/local_storage.dart';

class TeacherNavBar extends StatefulWidget {
  const TeacherNavBar({super.key});

  @override
  State<TeacherNavBar> createState() => _TeacherNavBarState();
}

class _TeacherNavBarState extends State<TeacherNavBar> {

  localStorage localUser = localStorage();
  late String _teacherName;

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
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder(
            future: localStorage().getUser(),
            builder: (context, snap){
              _teacherName = snap.data!.name.toString();
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
                      accountName: Text(snap.data!.name.toString()),
                      accountEmail: Text(snap.data!.email.toString()),

                      decoration:const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateExam()));
                      },
                      child: ListTile(
                        leading: Image.asset("assets/icons/take_exam.png",
                          color: const Color(0xff8523D9),),
                        title: const Text('Create Exam', style: SideBarTextStyle,),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateExam(),
                          ),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/exam-results.png", height: 30,
                        color: const Color(0xff8523D9),),
                      title: const Text('Edit Exam', style: SideBarTextStyle,),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Image.asset("assets/icons/feedback.png",
                        color: const Color(0xff8523D9),),
                        title: const Text('Review Result', style: SideBarTextStyle),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewResultsByTeacher(),
                        ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Image.asset("assets/icons/feedback.png",
                        color: const Color(0xff8523D9),),
                      title: const Text('Provide Feedback', style: SideBarTextStyle),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherFeedback(teacherName: _teacherName),
                        ),
                        );
                      },
                    ),

                    ListTile(
                      leading: Image.asset("assets/icons/feedback.png",
                        color: const Color(0xff8523D9),),
                      title: const Text('Access Report', style: SideBarTextStyle),
                      onTap: () {},
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
