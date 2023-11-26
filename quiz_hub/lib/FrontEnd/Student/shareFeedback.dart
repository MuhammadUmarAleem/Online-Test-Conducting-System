import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';

class ShareFeedback extends StatefulWidget {
  const ShareFeedback({super.key});

  @override
  State<ShareFeedback> createState() => _ShareFeedbackState();
}

class _ShareFeedbackState extends State<ShareFeedback> {

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

      body: Column(
        children: [
          Container(
            height: 120,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: RichText(
              text: const TextSpan(
                text: 'Access \n',
                style: HeadingStyle,
                children: <TextSpan>[
                  TextSpan(text: '  Exam',
                      style: HeadingStyle
                  ),
                ],
              ),
            ),
          ),


          //Menu Options (Access Exam)
          Container(
            height: 70,
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
                  child: Text("AI Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

              ],
            ),
          ),

          //Menu Options (Get Result)
          Container(
            height: 70,
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
                  child: Text("SE Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

              ],
            ),
          ),

          //Menu Options (Share Feedback)
          Container(
            height: 70,
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
                  child: Text("PPSD Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

              ],
            ),
          ),

          //Menu Options (Get Result)
          Container(
            height: 70,
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
                  child: Text("CN Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

                // https://www.fotor.com/images/create
              ],
            ),
          ),

          //Exam Options (MAD Exam)
          Container(
            height: 70,
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
                  child: Text("MAD Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

                // https://www.fotor.com/images/create
              ],
            ),
          ),

          //link to go to next screen
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:  const Text('Go Back', style: NormalTextStyleWhite,),
            ),
          ),

        ],
      ),

    );
  }
}
