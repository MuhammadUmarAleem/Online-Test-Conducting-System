import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Admin/adminDashboard.dart';

import '../../models/constants.dart';

class CreateUserAccount extends StatefulWidget {
  const CreateUserAccount({super.key});

  @override
  State<CreateUserAccount> createState() => _CreateUserAccountState();
}

class _CreateUserAccountState extends State<CreateUserAccount> {

  Constants constants = Constants();

  List<String> roleOptions = ["Admin", "Student", "Teacher"];
  String? selectedRole;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _CreateAccount() {
    // if (_formKey.currentState!.validate()) {
    //   var userInfo = {
    //     "firstName": firstNameController.text,
    //     "lastName": lastNameController.text,
    //     "email": emailController.text,
    //     "password": passwordController.text,
    //     "role": roleController.text,
    //   };
    //   var response =
    // }else{
    //
    // }
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

              const Text('QuizHub',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xff8523D9)),
              ),
              const SizedBox(height: 20),

              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Stay Connected \n",
                      style:NormalTextStyle,
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
                child: Image(image: AssetImage('assets/images/signup_illustration.png'),
                  height: 150 ,),
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
                        // onChanged: (_) => _formKey.currentState?.validate(),
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

                    //confirm password field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,

                        // onChanged: (value) => _formKey.currentState?.validate(),

                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please, Re-Enter Password'
                              : AppConstants.passwordRegex.hasMatch(value)
                              ? passwordController.text ==
                              confirmPasswordController.text
                              ? null
                              : 'Password not matched!'
                              : 'Invalid Password!';
                        },
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Confirm Password",
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
                        validator: (value) => value!.isEmpty ? "Select User Role" : null,
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
                        ), backgroundColor: constants.darkPurple,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Center(child: Text('Sign Up', style: TextStyle18,)
                      ),
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
