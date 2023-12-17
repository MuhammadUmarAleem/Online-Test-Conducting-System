import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_hub/Services/APICalls.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:http/http.dart' as http;

class ShowAllUsers extends StatefulWidget {
  const ShowAllUsers({super.key});

  @override
  State<ShowAllUsers> createState() => _ShowAllUsersState();
}

class _ShowAllUsersState extends State<ShowAllUsers> {
  Constants constants = Constants();
  APICalls showUsersAPI = APICalls();

  List<Map<String, dynamic>> users = [];

  Future<void> getUsers() async {
    try {
      final response = await showUsersAPI.showAllUsers();

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          users = List<Map<String, dynamic>>.from(data);
        });
      } else {
        // Handle error
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error loading users: $error');
    }
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Image(
                image: AssetImage('assets/images/QuizHub_Logo.png'),
                height: 45),
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'All Users',
                style: HeadingStyle2,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff8523D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text(
                    'Name',
                    style: TableHeadingTextStyle,
                  )),
                  DataColumn(
                      label: Text('Email', style: TableHeadingTextStyle)),
                  DataColumn(label: Text('Role', style: TableHeadingTextStyle)),
                ],
                rows: users.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        '${user['firstName']} ${user['lastName']}',
                        style: TableCellsTextStyle,
                      )),
                      DataCell(Text(user['email'], style: TableCellsTextStyle)),
                      DataCell(Text(user['role'], style: TableCellsTextStyle)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      //
      //     //All Users Widget
      //     UserList(),
      //
      //     //link to go to next screen
      //     Container(
      //       margin: const EdgeInsets.all(10.0),
      //       decoration: BoxDecoration(
      //         color: Colors.blue,
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //       padding: const EdgeInsets.symmetric(horizontal: 30),
      //       child: GestureDetector(
      //         onTap: (){
      //           Navigator.pop(context);
      //         },
      //         child:  const Text('Go Back', style: NormalTextStyleWhite,),
      //       ),
      //     ),
      //
      //   ],
      // ),
    );
  }
}

// //users list
// Widget UserList(){
//   return Expanded(
//     child: StreamBuilder(
//       stream: databaseServices.getQuizData(),
//       builder: (context, snapshot){
//         if(!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }
//         final doc = snapshot.data!.docs;
//         return ListView.builder(
//             itemCount: doc.length,
//             itemBuilder: (context, index){
//               print("This is doc : ${doc[index]["quizDuration"]}");
//               //     print("length of doc is: ${doc.length}");
//               return GestureDetector(
//                 onTap: () async{
//                   print('on tap working correctly');
//                   print('quiz TItle: ${doc[index]["quizTitle"]}');
//                   bool isQuizTaken = await checkIfQuizTaken(context, doc[index]['quizTitle']);
//                   print('quiz taken: ${isQuizTaken}');
//                   if(isQuizTaken){
//                     // User has already taken the quiz
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text("Quiz Already Taken"),
//                         content: Text("You've already attempted the quiz"),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text("OK"),
//                           ),
//                         ],
//                       ),
//                     );
//                   }else{
//                     Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                         StartExam(
//                           quizId: doc[index]['quizId'],
//                           quizTitle: doc[index]['quizTitle'],
//                           quizDuration: doc[index]['quizDuration'],
//                           noOfQuestions: doc[index]['noOfQuestion'],
//                         ),), );
//                   }
//                 },
//                 child: QuizTile(examTitle: doc[index]['quizTitle']),
//               );
//             });
//       },
//     ),
//   );
// }
//
//
// class UserTile extends StatelessWidget {
//   final String examTitle;
//
//   QuizTile({super.key, required this.examTitle});
//
//   Constants constants = Constants();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [
//             constants.darkPurple,
//             constants.darkPurple,
//             constants.darkPurple,
//             Colors.white.withOpacity(0.0),
//           ],
//         ),
//         border: Border.all(
//             width: 2,
//             color: Colors.grey.withOpacity(0.5)
//         ),
//
//         color: constants.whiteBackgroundBorder,
//         borderRadius: BorderRadius.circular(17),
//
//       ),
//       margin: const EdgeInsets.all(10.0),
//       padding: const EdgeInsets.all(15.0),
//
//
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             child: Text("$examTitle Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
//           ),
//
//         ],
//       ),
//
//     );
//   }
// }
