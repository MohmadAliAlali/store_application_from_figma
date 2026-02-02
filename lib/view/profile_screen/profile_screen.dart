import 'package:flutter/material.dart';
import 'package:task_5/controller/user_controller.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_style_text.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/global_valid.dart';
import 'package:task_5/core/navigation.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/state_manger.dart';
import 'package:task_5/core/widget/custom_button.dart';
import 'package:task_5/core/widget/custom_click_text.dart';
import 'package:task_5/core/widget/custom_text_field.dart';
import 'package:task_5/view/login_screen/login_screen.dart';
import 'package:task_5/view/nav_pages/nav_pages.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegisterController _registerController = RegisterController();

  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  void _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    String name = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String fcmToken = "mohamad"; // A static token for now

    var response =
    await _registerController.register(name, email, password, fcmToken);

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      AppState.login();
      moveTopNavPages();
    } else {
      _showErrorMessage("Login failed. Please check your input data .");
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: ScreenUtil.getWidth(16),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
          centerTitle: true,
          leading: CustomIcon(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: GlobalColor.iconColor,
            ),
            onPressed: () {
              if(Navigator.canPop(context) ){
              Navigator.pop(context);}
              else{

              }
            },
          )),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                    left: ScreenUtil.getWidth(30),
                    right: ScreenUtil.getWidth(30),
                  ),
                  child:
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 48,
                        backgroundImage:
                        AssetImage('assets/user.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CustomIconAction(
                          height: ScreenUtil.getHeight(30),
                          width: ScreenUtil.getWidth(30),
                          color: GlobalColor.greenButton,
                          onPressed: () {},
                          icon:const Icon(Icons.edit,size: 16,)
                      ),)

                    ],
                  )
              ),
              SizedBox(
                height: ScreenUtil.getHeight(30),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil.getWidth(0),
                    right: ScreenUtil.getWidth(0),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        text: 'Your Name',
                        controller: _usernameController,
                        hintText: 'Programmer X',
                        validator: (value) => GlobalValid.validUserName(
                            value), // Use the validator
                      ),
                      CustomTextField(
                        text: 'Email Address',
                        controller: _emailController,
                        hintText: 'Programmerx@gmail.com',
                        validator: (value) => GlobalValid.validEmail(value),
                        paddingBtm: ScreenUtil.getHeight(30),
                        paddingTop: ScreenUtil.getHeight(12),
                      ),
                      CustomTextField(
                        text: 'Password',
                        controller: _passwordController,
                        hintText: '........',
                        validator: (value) => GlobalValid.validPassword(value),
                        obscureText: obscureText,
                        paddingBtm: ScreenUtil.getHeight(20),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 0, bottom: 24),
                        width: ScreenUtil.getWidth(335),
                        alignment: Alignment.centerRight,
                        child: CustomClickText(
                          text: 'Recovery Password',
                          onPressed: () {},
                          textStyle: GlobalTextStyle.clickText,
                        ),
                      ),
                      CustomButton(
                        onPressed: _register,
                        child: isLoading
                            ? const CircularProgressIndicator()
                            :  Text(
                          'Save Now',
                          style: GlobalText.text18.copyWith(color: Colors.white),
                        ),
                      ),



                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void moveToLogin() {
    Navigation.navigateTo(context, const LoginScreen());
  }

  void moveTopNavPages() {
    Navigation.navigateAndRemove(context, const NavPages());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
