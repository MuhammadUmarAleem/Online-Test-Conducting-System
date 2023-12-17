import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Admin/createAccount.dart';
import 'package:quiz_hub/FrontEnd/Admin/showAllUsers.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/models/constants.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  Constants constants = Constants();

  // Function to show logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout logic here
                Navigator.of(context).pop(); // Close the dialog
                // Add your logout code here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
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
            Image(image: AssetImage('assets/images/QuizHub_Logo.png'), height: 45),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/person.png'),
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
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.5, 0),
                    end: const Alignment(0.5, 1.5),
                    colors: [
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
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Learning made easy with\n',
                        style: TextStyle(fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(text: 'QuizHub',
                              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Image(image: AssetImage("assets/images/graduation_cap_on_books_stack.png"),),
                  ],
                )
            ),

            //Create Account Button
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
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    child: Text("Create Account", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUserAccount(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Show All Accounts
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
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    child: Text("Show Users", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllUsers(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),


            //Edit Account Button
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
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Edit Account", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Delete Account Button
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
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Delete Account", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),
                      ),
                      );
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

            //Menu Options (Logout)
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
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Logout", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
                  ),

                  //link to go to next screen
                  GestureDetector(
                    onTap: (){
                      _showLogoutConfirmationDialog();
                    },
                    child:  const Icon(Icons.arrow_forward, color: Colors.white, size: 50),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
