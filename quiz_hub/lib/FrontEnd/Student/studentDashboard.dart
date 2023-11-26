import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/accessExam.dart';
import 'package:quiz_hub/FrontEnd/Student/getResult.dart';
import 'package:quiz_hub/FrontEnd/Student/shareFeedback.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/models/NavBar.dart';
import 'package:quiz_hub/models/constants.dart';

class studentDashboard extends StatefulWidget {
  const studentDashboard({super.key});

  @override
  State<studentDashboard> createState() => _studentDashboardState();
}

class _studentDashboardState extends State<studentDashboard> {

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      drawer: NavBar(),
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

      body: Column(
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
                borderRadius: BorderRadius.circular(17),
              ),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
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
              )
          ),

          //Menu Options (Access Exam)
          Container(
            height: 80,
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
              border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.5)
              ),

              color: constants.whiteBackgroundBorder,
              borderRadius: BorderRadius.circular(17),

            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(15.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("Access Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccessExam(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                ),

              ],
            ),
          ),

          //Menu Options (Get Result)
          Container(
            height: 80,
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
              border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.5)
              ),

              color: constants.whiteBackgroundBorder,
              borderRadius: BorderRadius.circular(17),

            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(15.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("Get Result", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GetResult(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                ),

              ],
            ),
          ),

          //Menu Options (Get Teacher Feedback)
          Container(
            height: 80,
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
              border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.5)
              ),

              color: constants.whiteBackgroundBorder,
              borderRadius: BorderRadius.circular(17),

            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(15.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("Teacher's Feedback", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareFeedback(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                ),

              ],
            ),
          ),

          //Menu Options (Logout)
          Container(
            height: 80,
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
              border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.5)
              ),

              color: constants.whiteBackgroundBorder,
              borderRadius: BorderRadius.circular(17),

            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(15.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("Logout", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
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

        ],
      ),

    );
  }
}
