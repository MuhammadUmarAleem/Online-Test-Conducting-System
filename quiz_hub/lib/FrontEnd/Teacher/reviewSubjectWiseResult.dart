import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/models/constants.dart';

import '../../Services/quizDatabase.dart';

class ReviewSubjectWiseResult extends StatefulWidget {
  String subjectName;
 ReviewSubjectWiseResult({super.key,
  required this.subjectName,
  });

  @override
  State<ReviewSubjectWiseResult> createState() => _ReviewSubjectWiseResultState();
}

class _ReviewSubjectWiseResultState extends State<ReviewSubjectWiseResult> {

  Constants constants = Constants();

  DB_Services databaseServices = new DB_Services();

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
              Text("   Review \n ${widget.subjectName} Result", style: HeadingStyle2,),

              //spacing
              SizedBox(height: 109),

              StreamBuilder(
                  stream: databaseServices.getSubjectWiseResultData(widget.subjectName),
                  builder: (context, resultSnap){
                    if (resultSnap.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (resultSnap.hasError) {
                      return Text('Error: ${resultSnap.error}');
                    } else{
                      final data = resultSnap.data!.docs;


                      return Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index){

                              final studentRegistration = data[index]["StudentRollNo"];
                              final quizScore = data[index]["QuizScore"];
                              final studentScore = data[index]["StudentScore"];

                              return DataTable(
                                columns: [
                                  DataColumn(label: Text('Sr.')),
                                  DataColumn(label: Text('Student Registration')),
                                  DataColumn(label: Text('Quiz Marks')),
                                  DataColumn(label: Text('Student Marks')),
                                ],
                                rows: [
                                  DataRow(cells: [

                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text('${data[index]["StudentRollNo"]}')),
                                    DataCell(Text('${data[index]["QuizScore"]}')),
                                    DataCell(Text('${data[index]["StudentScore"]}')),
                                  ]),
                                ],
                              );
                            }),
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
