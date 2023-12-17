import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/Services/Feedback_Handler_Sqflite.dart';
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/constants.dart';

import '../../models/NavBar.dart';
import '../../models/feedbackModel.dart';

class GetTeacherFeedback extends StatefulWidget {
  const GetTeacherFeedback({Key? key});

  @override
  State<GetTeacherFeedback> createState() => _GetTeacherFeedbackState();
}

class _GetTeacherFeedbackState extends State<GetTeacherFeedback> {
  Constants constants = Constants();
  late Future<List<FeedbackModel>> teacherFeedbackNotes;

  FeedbackHandlerSQLite? feedbackHandler;

  @override
  void initState() {
    super.initState();
    feedbackHandler = FeedbackHandlerSQLite();
    loadData();
  }

  loadData() async {
    teacherFeedbackNotes = feedbackHandler!.getFeedbackList();
  }

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
            Image(
              image: AssetImage('assets/images/QuizHub_Logo.png'),
              height: 45,
            ),
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
      body: Column(
        children: [
          Container(
            height: 120,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: RichText(
              text: TextSpan(
                text: ' Teacher \n',
                style: HeadingStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Feedback',
                    style: HeadingStyle,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: teacherFeedbackNotes,
              builder:
                  (context, AsyncSnapshot<List<FeedbackModel>> feedbackSnap) {
                if (feedbackSnap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (feedbackSnap.hasError) {
                  return Center(
                    child: Text('Error loading feedback'),
                  );
                } else if (feedbackSnap.data == null ||
                    feedbackSnap.data!.isEmpty) {
                  return Center(
                    child: Text('No feedback available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: feedbackSnap.data!.length,
                    itemBuilder: (context, index) {
                      return FeedbackCard(feedback: feedbackSnap.data![index]);
                    },
                  );
                }
              },
            ),
          ),
          // Link to go to the next screen
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => studentDashboard()));
              },
              child: Text(
                'Go Back',
                style: NormalTextStyleWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//feedback widget
class FeedbackCard extends StatelessWidget {
  final FeedbackModel feedback;

  const FeedbackCard({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          'Name:   ${feedback.teacherName.toString()}',
          style: TableHeadingTextStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Subject:   ${feedback.title.toString()}',
              style: TableCellsTextStyle,
            ),
            SizedBox(height: 8.0),
            Text(
              'Description:   ${feedback.description.toString()}',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
