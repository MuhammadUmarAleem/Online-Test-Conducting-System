import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';


class AIExam extends StatefulWidget {
  const AIExam({super.key});

  @override
  State<AIExam> createState() => _AIExamState();
}

class _AIExamState extends State<AIExam> {

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
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
        iconTheme: IconThemeData(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

      ),

      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/pen_on_paper.png"), height: 150,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              margin: EdgeInsets.only(bottom: 10),
              child: Text("AI Exam", style: HeadingStyle2,),
            ),
            
            Text("Q1: Who is the inventor of Aritificial Intelligence?", style: NormalTextStyle,),
            SizedBox(height: 15),

            //Question Options

            //Option-1
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: constants.darkPurple,
                borderRadius: BorderRadius.circular(10),

              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),
                      ),
                      );
                    },
                    child: Text("Geoffrey Hinton", style: OptionTextStyle,),

              ),
            ),

            //Option-2
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: constants.darkPurple,
                borderRadius: BorderRadius.circular(10),

              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),
                  ),
                  );
                },
                child: Text("Andrew Ng", style: OptionTextStyle,),

              ),
            ),

            //Option-3
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

              width: double.infinity,
              decoration: BoxDecoration(
                color: constants.darkPurple,
                borderRadius: BorderRadius.circular(10),

              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),
                  ),
                  );
                },
                child: Text("John McCarthy", style: OptionTextStyle,),

              ),
            ),

            //Option-4
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: constants.darkPurple,
                borderRadius: BorderRadius.circular(10),

              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),
                  ),
                  );
                },
                child: Text("Jurgen Schmidhuber", style: OptionTextStyle,),
              ),
            ),
            Row(
              children: [
                //link to go to next screen
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:  Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                        Text('Go Back', style: NormalTextStyleWhite,),
                      ],
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
