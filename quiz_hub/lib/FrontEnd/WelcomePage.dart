import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/signup.dart';
import 'package:quiz_hub/models/constants.dart';

class WelcomePage extends StatefulWidget {
   WelcomePage({super.key});


  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.whiteBackgroundBorder,
      body: Container(
       decoration: BoxDecoration(
         color: constants.backGroundColor,
           borderRadius: BorderRadius.circular(17),
       ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [

            Text('QuizHub',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xff8523D9)),
            ),
            SizedBox(height: 50),

            Text('Online Test Conducting System',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff8523D9)),
            ),
            Text('Catalyze Learning With Ease',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Color(0xff8523D9)),
            ),
            SizedBox(height: 100),

            //logo placement
            Center(
              child: Image(image: AssetImage('assets/images/QuizHub_Logo.png'),
                height: 150 ,),
            ),
            SizedBox(height: 150),

              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(width: 5, color: constants.darkPurple),
                ),
                child: ElevatedButton(
             onPressed: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => SignUpScreen()),
               );                    },
                    style: ElevatedButton.styleFrom(
                      //Change font size
                      textStyle: const TextStyle(
                        fontSize: 22,
                      ),
                      primary: constants.darkPurple,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Get Started'),  // Replace 'Add' with your button text
                    SizedBox(width: 8),  // Add some spacing between the icon and text
                    Icon(Icons.arrow_forward),  // Replace 'Icons.add' with the desired icon
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
