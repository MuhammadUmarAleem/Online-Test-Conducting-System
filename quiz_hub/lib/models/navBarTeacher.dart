import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Teacher/createExam.dart';
import 'package:quiz_hub/models/constants.dart';
import '../localStorage/local_storage.dart';

class TeacherNavBar extends StatefulWidget {
  const TeacherNavBar({super.key});

  @override
  State<TeacherNavBar> createState() => _TeacherNavBarState();
}

class _TeacherNavBarState extends State<TeacherNavBar> {

  localStorage localUser = localStorage();

  @override
  Widget build(BuildContext context) {
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
                        onTap: () {},
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
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Image.asset("assets/icons/feedback.png",
                        color: const Color(0xff8523D9),),
                      title: const Text('Provide Feedback', style: SideBarTextStyle),
                      onTap: () {},
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
                    ),
                  ],
                );
              }
            })
    );
  }
}
