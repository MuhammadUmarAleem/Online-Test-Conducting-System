import 'package:cloud_firestore/cloud_firestore.dart';

class DB_Services{

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async{
try{

   await _firebaseFirestore.collection("Quiz")
       .doc(quizId).set(
     quizData,
   );
   print('Quiz Data added successfully');
}catch(e){
  print(e.toString());
}
 }

  Future<void> addQuestionData(Map<String, dynamic> questionData, String quizId) async{
    try{
      await _firebaseFirestore.collection("Quiz")
          .doc(quizId).collection("QnA").add(
          questionData
      );
      print('Question data added successfully');
    }catch(e){
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getQuizData() {
   return _firebaseFirestore.collection("Quiz").snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getQuizQuestions(String quizId)  async{
   return await _firebaseFirestore.collection("Quiz")
       .doc(quizId).collection("QnA").get();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getQuizQuestion(String quizId) {
    return _firebaseFirestore.collection("Quiz").doc(quizId).collection("QnA").snapshots();
  }

  //adding student result data
  Future<void> addStudentResultData(Map<String, dynamic> studentResultData, studentID) async{
    try{

      String quizId = studentResultData["quizId"].toString();
      String quizTitle = studentResultData["quizTitle"].toString();
        await _firebaseFirestore.collection("Quiz Result").doc("${quizTitle} result")
      .collection("Student Results").doc(studentID).set(studentResultData);
      print('Result Data added successfully');
        print(studentResultData);
    }catch(e){
      print(e.toString());
    }
  }

  //obtaining student result data

  Stream<QuerySnapshot<Map<String, dynamic>>> getSubjectWiseResultData(String subjectResult) {
  return  _firebaseFirestore.collection('Quiz Result').doc('${subjectResult} result')
      .collection("Student Results").snapshots();
}
}