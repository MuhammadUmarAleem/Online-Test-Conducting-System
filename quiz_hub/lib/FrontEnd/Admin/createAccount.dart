import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Admin/adminDashboard.dart';
import 'package:http/http.dart' as http;
import '../../Services/APICalls.dart';
import '../../models/constants.dart';

class CreateUserAccount extends StatefulWidget {
  const CreateUserAccount({super.key});

  @override
  State<CreateUserAccount> createState() => _CreateUserAccountState();
}

class _CreateUserAccountState extends State<CreateUserAccount> {
  Constants constants = Constants();
  APICalls loginAPI = APICalls();

  bool isValidate = false;
  String backEnd_URL = 'https://organized-beaded-vacation.glitch.me';
  List<String> roleOptions = ["Admin", "Student", "Teacher"];
  String? selectedRole;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userRegistration = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _CreateAccount() async {
    try {
      if (_formKey.currentState!.validate()) {
        var userReqBody = {
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
          "rollNo": userRegistration.text,
          "password": passwordController.text,
          "role": selectedRole,
        };

        var registerUser = await loginAPI.CreateAccount(userReqBody);

        print('user Registered: ${registerUser.statusCode}');

        //if user register successfully
        if (registerUser.statusCode == 201) {
          // _showSuccessPopup(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text('User Registered Successfully'),
            ),
          );

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminDashboard()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text('Failed to register user'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Please enter valid credentials'),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Error occurred. ${error}'),
        ),
      );
    }
  }

  // Function to show the success popup
  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Registration'),
          content: Text('User Registered Successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // You can navigate to another screen or perform any other action here
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.whiteBackgroundBorder,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: constants.backGroundColor,
            borderRadius: BorderRadius.circular(17),
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'QuizHub',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Color(0xff8523D9)),
              ),
              const SizedBox(height: 20),

              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Stay Connected \n",
                      style: NormalTextStyle,
                    ),
                    TextSpan(
                      text:
                          "Create an account and get access to valuable content and quizess ",
                      style: ThinTextStyle,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),

              const SizedBox(height: 15),

              //logo placement
              const Center(
                child: Image(
                  image: AssetImage('assets/images/signup_illustration.png'),
                  height: 150,
                ),
              ),

              const SizedBox(height: 20),

              //sign up form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //first Name input
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter First Name ';
                          }
                        },
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                        ),
                      ),
                      height: 40,
                    ),

                    const SizedBox(height: 10),

                    //lastname input field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        // onChanged: (_) => _formKey.currentState?.validate(),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Last Name ';
                          }
                        },
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                      ),
                      height: 40,
                    ),

                    const SizedBox(height: 10),

                    //email input field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        // onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please, Enter Email Address'
                              : AppConstants.emailRegex.hasMatch(value)
                                  ? null
                                  : 'Invalid Email Address';
                        },
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                      height: 40,
                    ),

                    const SizedBox(height: 10),

                    //password input field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        // onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please, Enter Password'
                              : AppConstants.passwordRegex.hasMatch(value)
                                  ? null
                                  : 'Invalid Password';
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                      height: 40,
                    ),

                    const SizedBox(height: 10),

                    //User Registration field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: userRegistration,
                        decoration: const InputDecoration(
                          hintText: "Student Registration",
                        ),
                      ),
                      height: 40,
                    ),
                    const SizedBox(height: 10),

                    //Role Assignment field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonFormField(
                        value: selectedRole,
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                        items: roleOptions.map((title) {
                          return DropdownMenuItem(
                            value: title,
                            child: Text(title),
                          );
                        }).toList(),
                        validator: (value) =>
                            value!.isEmpty ? "Select User Role" : null,
                        decoration: const InputDecoration(
                          hintText: "Role Assignment",
                        ),
                      ),
                      height: 40,
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: _CreateAccount,
                      style: ElevatedButton.styleFrom(
                        //Change font size
                        textStyle: const TextStyle(
                          height: 0.7,
                          fontSize: 22,
                        ),
                        backgroundColor: constants.darkPurple,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Center(
                          child: Text(
                        'Create Account',
                        style: TextStyle18,
                      )),
                    ),
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
