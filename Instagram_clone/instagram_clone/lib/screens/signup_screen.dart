// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 48.0,
              ),
              SizedBox(
                height: 32.0,
              ),
              //circular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            "https://media-exp1.licdn.com/dms/image/C5603AQHVz4NCIqaHWg/profile-displayphoto-shrink_800_800/0/1634835225793?e=2147483647&v=beta&t=gPm6MN0XyqdS5eAricGZ-dCi5h15mgpjlLUABf6sILk",
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: (() async {
                        Uint8List image = await pickImage(ImageSource.gallery);
                        setState(() {
                          _image = image;
                        });
                      }),
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 24,
              ),

              TextFieldInput(
                hintText: "username",
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
                isPassword: false,
              ),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: "email",
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                isPassword: false,
              ),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: "password",
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPassword: true,
              ),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: "bio",
                textInputType: TextInputType.text,
                textEditingController: _bioController,
                isPassword: false,
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: sigUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  decoration: ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  child: Text("Sign up"),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Already have an account? "),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Log in.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )

              //sign up etc
            ],
          ),
        ),
      ),
    );
  }

  void sigUpUser() async {
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    print(res);
  }
}
