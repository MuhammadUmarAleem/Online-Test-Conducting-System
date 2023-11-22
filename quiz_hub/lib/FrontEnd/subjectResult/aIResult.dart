import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';

class AIResult extends StatelessWidget {
  final String subject;
  final int score;

  AIResult({super.key, required this.subject, required this.score });

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
              backgroundColor: Colors.white,
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

      ),

      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Image(image: AssetImage("assets/images/exam-results.png"), height: 150,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text("Result", style: HeadingStyle2,),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subject:', style: TextStyle(fontSize: 20)),
                Text('$subject', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Score:', style: TextStyle(fontSize: 20)),
                Text('$score', style: TextStyle(fontSize: 20)),
              ],
            ),
                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => studentDashboard(),
                      ),
                      );
                    },
                    child:  Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                      color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, color: Colors.white, size: 30),
                          SizedBox(width: 5,),
                          Text('Go Back', style: TextStyle18,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
          );
  }
}
