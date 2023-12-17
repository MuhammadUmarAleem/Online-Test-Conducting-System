import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/showSubjectResult.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';

class GetResult extends StatefulWidget {
  GetResult({super.key });

  @override
  State<GetResult> createState() => _GetResultState();
}

class _GetResultState extends State<GetResult> {
  Constants constants = Constants();

//variables and object for obtaining user logged in credentials
  late String _userRollNo, _userEmail, _userName;

  localStorage localstorage = localStorage();

  //obtaining user logged in credentials
  Future<void> getUserName() async {
    var login_response = await localStorage().getUser();

    _userRollNo = login_response.rollNo.toString();
    _userEmail = login_response.email.toString();
    _userName = login_response.name.toString();
    print('initialization ${_userEmail}');
  }

  @override
  void initState() {
  getUserName();
    super.initState();
  }

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
                text: '  Get \n',
                style: HeadingStyle,
                children: <TextSpan>[
                  TextSpan(text: 'Result',
                      style: HeadingStyle
                  ),

                ],
              ),
            ),
          ),

          //Menu Options (Access Result)
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
                  child: Text("AI Result", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectWiseResult(
                        subjectName: 'AI', userEmail: _userEmail, userRollNo: _userRollNo, userName: _userName),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

              ],
            ),
          ),

          //Menu Options (SE Result)
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
                  child: Text("SE Result", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectWiseResult(
                        subjectName: 'SE', userEmail: _userEmail, userRollNo: _userRollNo, userName: _userName),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

              ],
            ),
          ),

          //Menu Options (PPSD Result)
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
                  child: Text("PPSD Result", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectWiseResult(
                        subjectName: 'PPSD', userEmail: _userEmail, userRollNo: _userRollNo, userName: _userName),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

              ],
            ),
          ),

          //Menu Options (CN Result)
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
                  child: Text("CN Result", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectWiseResult(
                        subjectName: 'CN', userEmail: _userEmail, userRollNo: _userRollNo, userName: _userName),
                    ),
                    );
                  },
                  child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                ),

                // https://www.fotor.com/images/create
              ],
            ),
          ),

          //Exam Options (MAD Result)
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
                  child: Text("MAD Result", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                ),

                //link to go to next screen
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectWiseResult(
                        subjectName: 'MAD', userEmail: _userEmail, userRollNo: _userRollNo, userName: _userName),
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
