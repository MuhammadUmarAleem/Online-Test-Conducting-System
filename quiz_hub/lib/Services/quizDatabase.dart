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

  getQuizData() async {
   await _firebaseFirestore.collection("Quiz").snapshots();
  }
}