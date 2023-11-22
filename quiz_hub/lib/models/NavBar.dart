import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context){
      return Drawer(
        child: FutureBuilder(
          future:localStorage().getUser(),
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
                ListTile(
                  leading: Image.asset("assets/icons/take_exam.png",
                    color: const Color(0xff8523D9),),
                  title: const Text('Access Exam', style: SideBarTextStyle,),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/icons/exam-results.png", height: 30,
                    color: const Color(0xff8523D9),),
                  title: const Text('Get Result', style: SideBarTextStyle,),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset("assets/icons/feedback.png",
                    color: const Color(0xff8523D9),),
                  title: const Text('Share Feedback', style: SideBarTextStyle),
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
