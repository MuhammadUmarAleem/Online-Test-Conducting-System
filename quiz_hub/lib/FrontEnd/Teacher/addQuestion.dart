import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Teacher/TeacherDashboard.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';
import 'package:quiz_hub/models/constants.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  final int totalQuestions;
  const AddQuestion(this.quizId, this.totalQuestions);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();

  Constants constants = Constants();

  String? question, option1, option2, option3, option4;

  bool _isLoading = false;
  String? trueOption;
  int? radioOption;
  int totalAddedQuestions = 0;

      DB_Services databaseServices = new DB_Services();
  // int _totalQuestions = totalQuestions;

  UploadQuestion() async{
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> questionMap = {
        "Question" : question,
        "Option1" : option1,
        "Option2" : option2,
        "Option3" : option3,
        "Option4" : option4,
        "CreatedAt": DateTime.now(),
        "UpdatedAt" : DateTime.now(),
        "Active" : true,
        "trueAnswer" : trueOption,
      };
      await databaseServices.addQuestionData(questionMap, widget.quizId)
          .then((value) {
         setState(() {
           _isLoading = false;
         });
      });
      // Increment clicks when a question is added
      totalAddedQuestions++;
      // Check if the number of clicks equals totalQuestions
      if (totalAddedQuestions == widget.totalQuestions) {
        // Disable "Add Question" button and enable "Submit" button
        setState(() {
          addQuestionButtonDisabled = true;
          submitButtonDisabled = false;
        });
      }
    }
  }

  bool addQuestionButtonDisabled = false;
  bool submitButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Container(
        decoration: BoxDecoration(
          // color: constants.backGroundColor,
          borderRadius: BorderRadius.circular(17),
        ),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              const Text('QuizHub',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xff8523D9)),
              ),

              const SizedBox(height: 30),

              //Create Exam
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Question Description
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),

                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? "Enter Question Description" : null,
                        decoration: const InputDecoration(
                          hintText: "Question Description",
                        ),
                        onChanged: (value){
                          question = value;
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Option1
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? "Enter Option 1" : null,
                              onChanged: (opt1){
                                option1 = opt1;
                              },
                              decoration: const InputDecoration(
                                hintText: "Option 1",
                              ),
                            ),
                          ),
                          Radio(
                            value: 1,
                            groupValue: radioOption,
                            onChanged: (value) {
                              setState(() {
                                radioOption = value;
                                trueOption = option1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Option 2
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? "Enter Option 2" : null,
                              onChanged: (opt2){
                                option2 = opt2;
                              },
                              decoration: const InputDecoration(
                                hintText: "Option 2",
                              ),
                            ),
                          ),
                          Radio(
                            value: 2,
                            groupValue: radioOption,
                            onChanged: (value) {
                              setState(() {
                                radioOption = value;
                                trueOption = option2;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    //Option 3
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? "Enter Option 3" : null,
                              onChanged: (opt3){
                                option3 = opt3;
                              },
                              decoration: const InputDecoration(
                                hintText: "Option 3",
                              ),
                            ),
                          ),
                          Radio(
                            value: 3,
                            groupValue: radioOption,
                            onChanged: (value) {
                              setState(() {
                                radioOption = value;
                                trueOption = option3;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    //Option 4
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? "Enter Option 4" : null,
                              onChanged: (opt4){
                                option4 = opt4;
                              },
                              decoration: const InputDecoration(
                                hintText: "Option 4",
                              ),
                            ),
                          ),
                          Radio(
                            value: 4,
                            groupValue: radioOption,
                            onChanged: (value) {
                              setState(() {
                                radioOption = value;
                                trueOption = option4;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        //submit exam button
                        // if(widget.totalQuestions ==    )
                        GestureDetector(
                          onTap: (){
                            submitButtonDisabled ? null :
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherDashboard(),),);
                          },
                          child:  Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              // width: double.infinity,
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(100),
                                color: constants.darkPurple,
                              ),
                              child: Text('Submit Exam', style: TextStyle18,)
                          ),
                        ),

                        SizedBox(width: 10,),
                        //Add Question button
                        GestureDetector(
                          onTap: (){
                            addQuestionButtonDisabled ? null : UploadQuestion();
                          },
                          child:  Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(100),
                                color: constants.darkPurple,
                              ),
                              child: Text('Add Question', style: TextStyle18,)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
