import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/accessExam.dart';
import 'package:quiz_hub/FrontEnd/Student/getResult.dart';
import 'package:quiz_hub/FrontEnd/Student/shareFeedback.dart';
import 'package:quiz_hub/FrontEnd/Teacher/createExam.dart';
import 'package:quiz_hub/FrontEnd/Teacher/reviewResults.dart';
import 'package:quiz_hub/FrontEnd/Teacher/teacherFeedback.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';
import 'package:quiz_hub/models/navBarTeacher.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  //object for local storage
  localStorage local_storage = localStorage();
  //teacher name for fetching
  late String _teacherName;
  //making constant object to style text and colors
  Constants constants = Constants();

  //function for getting teacher name
  Future<void> getTeacherName() async{
    var login_response = await localStorage().getUser();
    _teacherName = login_response.name.toString();
  }

  @override
  void initState() {
    getTeacherName();
    super.initState();
  }

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
    return Scaffold(
      drawer: TeacherNavBar(),
      backgroundColor: constants.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Image(image: AssetImage('assets/images/QuizHub_Logo.png'), height: 45),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/person.png'),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.5, 0),
                    end: const Alignment(0.5, 1.5),
                    colors: [
                      constants.darkPurple,
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                  border: Border.all(
                      width: 2,
                      color: Colors.grey.withOpacity(0.5)
                  ),

                  color: constants.whiteBackgroundBorder,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Learning made easy with\n',
                          style: TextStyle(fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(text: 'QuizHub',
                                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Image(image: AssetImage("assets/images/graduation_cap_on_books_stack.png"),),
                    ],
                  ),
                )
            ),

            //Menu Options (Create Exam)
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    constants.darkPurple,
                    constants.darkPurple,
                    constants.darkPurple,
                    Colors.white.withOpacity(0.0),
                  ],
                ),

                color: constants.whiteBackgroundBorder,
                borderRadius: BorderRadius.circular(10),

              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Create Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateExam(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Menu Options (Edit Exam)
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    constants.darkPurple,
                    constants.darkPurple,
                    constants.darkPurple,
                    Colors.white.withOpacity(0.0),
                  ],
                ),

                color: constants.whiteBackgroundBorder,
                borderRadius: BorderRadius.circular(10),

              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Edit Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateExam(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Menu Options (Review Result)
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    constants.darkPurple,
                    constants.darkPurple,
                    constants.darkPurple,
                    Colors.white.withOpacity(0.0),
                  ],
                ),

                color: constants.whiteBackgroundBorder,
                borderRadius: BorderRadius.circular(10),

              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Review Result", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewResultsByTeacher(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Menu Options (Provide Feedback)
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    constants.darkPurple,
                    constants.darkPurple,
                    constants.darkPurple,
                    Colors.white.withOpacity(0.0),
                  ],
                ),

                color: constants.whiteBackgroundBorder,
                borderRadius: BorderRadius.circular(10),

              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Provide Feedback", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherFeedback(teacherName: _teacherName),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Menu Options (Access Report)
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    constants.darkPurple,
                    constants.darkPurple,
                    constants.darkPurple,
                    Colors.white.withOpacity(0.0),
                  ],
                ),

                color: constants.whiteBackgroundBorder,
                borderRadius: BorderRadius.circular(10),

              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Access Report", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Menu Options (Schedule Exam)
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    constants.darkPurple,
                    constants.darkPurple,
                    constants.darkPurple,
                    Colors.white.withOpacity(0.0),
                  ],
                ),

                color: constants.whiteBackgroundBorder,
                borderRadius: BorderRadius.circular(10),

              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Logout", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      _showLogoutConfirmationDialog();
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
