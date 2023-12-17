import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Admin/adminDashboard.dart';
import 'package:quiz_hub/FrontEnd/Admin/createAccount.dart';
import 'package:quiz_hub/FrontEnd/Admin/showAllUsers.dart';
import 'package:quiz_hub/FrontEnd/Exam/submitResponse.dart';
import 'package:quiz_hub/FrontEnd/Student/accessExam.dart';
import 'package:quiz_hub/FrontEnd/Student/getResult.dart';
import 'package:quiz_hub/FrontEnd/Student/getTeacherFeedback.dart';
import 'package:quiz_hub/FrontEnd/Student/shareFeedback.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/FrontEnd/Teacher/TeacherDashboard.dart';
import 'package:quiz_hub/FrontEnd/Teacher/addQuestion.dart';
import 'package:quiz_hub/FrontEnd/Teacher/createExam.dart';
import 'package:quiz_hub/FrontEnd/Teacher/teacherFeedback.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_hub/FrontEnd/login.dart';
import 'FrontEnd/signup.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: WelcomePage(
      ),
    );
  }
}

