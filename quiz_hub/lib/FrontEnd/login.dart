import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/FrontEnd/signup.dart';

import '../models/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Constants constants = Constants();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => studentDashboard()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.whiteBackgroundBorder,
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            color: constants.backGroundColor,
            borderRadius: BorderRadius.circular(17),
          ),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [

              Text('QuizHub',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xff8523D9)),
              ),
              SizedBox(height: 25),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Stay Connected \n",
                      style:NormalTextStyle,
                    ),
                    TextSpan(
                      text:
                      "Enter your email address and password to get access to your account ",
                      style: ThinTextStyle,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),

              SizedBox(height: 25),

              //logo placement
              Center(
                child: Image(image: AssetImage('assets/images/login_authentication.png'),
                  height: 200 ,),
              ),

              SizedBox(height: 30),

              //sign up form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //email input field
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),

                      ),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: _login,
                      style:
                      ElevatedButton.styleFrom(
                        //Change font size
                        textStyle: const TextStyle(
                          height: 0.5,
                          fontSize: 22,
                        ),
                        primary: constants.darkPurple,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                        child: Center(child: Text('Login', style: TextStyle18,)
                        ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              //button for going to login page
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: ThinTextStyle,
                  children: [
                    TextSpan(
                        text: 'SignUp',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                        }
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
