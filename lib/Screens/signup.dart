import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_5/Screens/login.dart';
import 'package:task_5/Screens/todo.dart';
import 'package:task_5/widgets/validation.dart';
import '../widgets/custom_filled_button.dart';
import '../widgets/logsign_tailing_text.dart';
import '../widgets/my_text_form_field.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  late  TextEditingController _nameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passController = TextEditingController();
  bool _passHide = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _passHide = true;
  }


  void _submitForm() async {
    if(_formKey.currentState!.validate()){

      final prefs = await SharedPreferences.getInstance();
      final Map<String, dynamic> users = Map<String, dynamic>.from(
          prefs.getString('users') != null ? jsonDecode(prefs.getString('users')!) : {}
      );

      if (users.containsKey(_emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User with this email already exists!")));
        return;
      }

      users[_emailController.text] = {
        'name': _nameController.text,
        'password': _passController.text,
      };

      await prefs.setString('users', jsonEncode(users));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TodoScreen(name: _nameController.text, email: _emailController.text,)));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Form!")));
    }
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 71, 24, 173),
      body: GestureDetector(
        onTap: () {
          _nameFocusNode.unfocus();
          _emailFocusNode.unfocus();
          _passFocusNode.unfocus();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 80,
                right: 114,
                child:
                SizedBox(
                    width: 327,
                    height: 274,
                    child: Image.asset("assets/images/signup_image.png"))
            ),
            const Positioned(
                top: 190,
                left: 270,
                child: Text("Get\nStarted!", textAlign: TextAlign.center, style:
                TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)
            ),
            SafeArea(
              child: Column(
                children: [
                  const Expanded(
                      flex: 3,
                      child: SizedBox(height: 10)
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)
                          )
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: double.infinity),
                                const Padding(
                                  padding: EdgeInsets.all(22.0),
                                  child: Text("Sign Up", style: TextStyle(
                                      color: Color.fromARGB(255, 71, 24, 173),
                                      fontSize: 30, fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyTextFormField(labelText: "Name", focusNode: _nameFocusNode,
                                    validate: validateName, controller: _nameController,),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    MyTextFormField(labelText: "Email", focusNode: _emailFocusNode,
                                    validate: validateEmail, controller: _emailController,),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    MyTextFormField(labelText: "Password", focusNode: _passFocusNode,
                                    validate: validatePass,
                                    hidePass: _passHide,
                                    suffixIcon: IconButton(onPressed: (){
                                      setState(() {
                                        _passHide = !_passHide;
                                      });
                                    }, icon: Icon(_passHide
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined)),
                                      controller: _passController),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TailingText(title: "Yes, I agree to the ", converterTitle: "Terms&Services.",
                                      onTapCall: () {}),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    CustomFilledButton(title: "Proceed", onPressed: _submitForm),
                                    const SizedBox(
                                      height: 45,
                                    ),
                                     TailingText(title: "Existing User?", converterTitle: "Log In",
                                      onTapCall: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => const LoginScreen()));
                                      },)
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
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