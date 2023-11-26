import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/FrontEnd/Teacher/TeacherDashboard.dart';
import 'package:quiz_hub/FrontEnd/signup.dart';
import 'package:quiz_hub/Services/APICalls.dart';
import 'package:quiz_hub/models/loginResponse.dart';
import 'package:quiz_hub/models/loginRole.dart';

import '../models/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Constants constants = Constants();
  APICalls loginAPI = APICalls();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
try{
      loginResponse response = await loginAPI.loginAPI(emailController.text, passwordController.text);

      roleLogin userRole = await loginAPI.getUserRole(response.token!);
      if(userRole.data!.role == "Admin"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const studentDashboard()));
      }else if(userRole.data!.role == "Teacher"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TeacherDashboard()));
      }

      // Navigator.push(context, MaterialPageRoute(builder: (context) => const studentDashboard()));
    }catch(err){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
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
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              const Text('QuizHub',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xff8523D9)),
              ),
              const SizedBox(height: 25),

              RichText(
                text: const TextSpan(
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

              const SizedBox(height: 25),

              //logo placement
              const Center(
                child: Image(image: AssetImage('assets/images/login_authentication.png'),
                  height: 200 ,),
              ),

              const SizedBox(height: 30),

              //sign up form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                    ),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        // onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please, Enter Password'
                              : null;
                              // : 'Invalid Password';
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),

                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: _login,
                      style:
                      ElevatedButton.styleFrom(
                        //Change font size
                        textStyle: const TextStyle(
                          height: 0.5,
                          fontSize: 22,
                        ), backgroundColor: constants.darkPurple,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                        child: const Center(child: Text('Login', style: TextStyle18,)
                        ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //button for going to login page
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: ThinTextStyle,
                  children: [
                    TextSpan(
                        text: 'SignUp',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
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
