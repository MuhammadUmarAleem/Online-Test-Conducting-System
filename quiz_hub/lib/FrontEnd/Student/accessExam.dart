import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Exam/aiExam.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';
import 'package:snapshot/snapshot.dart';

class AccessExam extends StatefulWidget {
  const AccessExam({super.key});

  @override
  State<AccessExam> createState() => _AccessExamState();
}

class _AccessExamState extends State<AccessExam> {

  Constants constants = Constants();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance ;
  // return await _firebaseFirestore.collection("Quiz").snapshots();

  DB_Services databaseServices = new DB_Services();

  Widget QuizList(){
    return Expanded(
      child: StreamBuilder(
        stream: _firebaseFirestore.collection("Quiz").snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final doc = snapshot.data!.docs;
             return ListView.builder(
                itemCount: doc.length,
                  itemBuilder: (context, index){
                  print(doc[index]['quizTitle']);
                    return QuizTile(examTitle: snapshot.data!.docs[index]['quizTitle']);
                  });
        },
      ),
    );
  }

// @override
//   void initState() {
//   databaseServices.getQuizData().then((value){
//     setState(() {
//       quizStream = value;
//     });
//   });
//     super.initState();
//   }

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
          QuizList(),


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

class QuizTile extends StatelessWidget {
  final String examTitle;

  QuizTile({super.key, required this.examTitle});

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text("$examTitle Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
          ),

        ],
      ),

    );
  }
}
