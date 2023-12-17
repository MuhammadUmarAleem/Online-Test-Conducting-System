import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';

import '../../models/constants.dart';

class SubjectWiseResult extends StatefulWidget {

  String subjectName, userEmail, userRollNo, userName;
SubjectWiseResult({
  super.key, required this.subjectName, required this.userEmail, required this.userRollNo, required this.userName
});


  @override
  State<SubjectWiseResult> createState() => _SubjectWiseResultState();
}

class _SubjectWiseResultState extends State<SubjectWiseResult> {

  Constants constants = Constants();
  DB_Services db_services = DB_Services();

  // final getStudentResult = db_services.getStudentResultData(widget.subjectName, widget.userRollNo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              //quiz title
              Text("     ${widget.subjectName} \nResult", style: HeadingStyle2,),

              //spacing
              SizedBox(height: 109),

              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Quiz Result').doc('${widget.subjectName} result')
                  .collection("Student Results").doc(widget.userRollNo).snapshots(),
                  builder: (context, resultSnap){
                    if (resultSnap.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (resultSnap.hasError) {
                      return Text('Error: ${resultSnap.error}');
                    } else{
                      final data = resultSnap.data!.data();

                      if (data == null) {
                        print('data is ${data}');
                        return Text('No data available', style: NormalTextStyle,);
                      }
                      final subjectName = data["quizTitle"];
                      final quizScore = data["QuizScore"];
                      final studentScore = data["StudentScore"];
                      return Column(
                        children: [

                          // Table to summarize student details
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                children: [
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Text('Student Name', style: TableHeadingTextStyle ))),
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Center(child: Text(widget.userName, style: TableCellsTextStyle,)))),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Text('Registration Number', style: TableHeadingTextStyle ))),
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Center(child: Text(widget.userRollNo, style: TableCellsTextStyle,)))),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Text('Subject', style: TableHeadingTextStyle ))),
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Center(child: Text(subjectName, style: TableCellsTextStyle,)))),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Text('Quiz Marks', style: TableHeadingTextStyle ))),
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Center(child: Text('$quizScore', style: TableCellsTextStyle,)))),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Text('Student Marks', style: TableHeadingTextStyle ))),
                                  TableCell(child: Padding(padding: EdgeInsets.all(5), child: Center(child: Text('$studentScore', style: TableCellsTextStyle,)))),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  }
              ),

              SizedBox(height: 150),

              //Back button
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => studentDashboard()));
                },
                child:  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff1640D6),
                    ),
                    child: Text('Go Back', style: TextStyle18,)
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
