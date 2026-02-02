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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          backgroundColor: GlobalColor.backgroundPage,
          leading: CustomIcon(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: GlobalColor.iconColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      backgroundColor: GlobalColor.backgroundPage,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil.getWidth(30),
                    right: ScreenUtil.getWidth(30),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Register Account',
                        style: GlobalText.text30,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: ScreenUtil.getHeight(8),
                      ),
                      const Text(
                        'Fill your details or continue with social media',
                        style: GlobalText.textSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
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
                        hintText: 'Enter your Email',
                        validator: (value) => GlobalValid.validUserName(
                            value), // Use the validator
                      ),
                      CustomTextField(
                        text: 'Email Address',
                        controller: _emailController,
                        hintText: 'Enter your Email',
                        validator: (value) => GlobalValid.validEmail(value),
                        paddingBtm: ScreenUtil.getHeight(30),
                        paddingTop: ScreenUtil.getHeight(12),
                      ),
                      CustomTextField(
                        text: 'Password',
                        controller: _passwordController,
                        hintText: 'Enter your Password',
                        validator: (value) => GlobalValid.validPassword(value),
                        suffixIcon: Icons.remove_red_eye,
                        obscureText: obscureText,
                        paddingBtm: ScreenUtil.getHeight(40),
                      ),
                      CustomButton(
                        onPressed: _register,
                        child: isLoading
                            ? const CircularProgressIndicator()
                            :  Text(
                                'Sign up',
                                style: GlobalText.text18.copyWith(color: Colors.white),
                              ),
                      ),
                      SizedBox(
                        height: ScreenUtil.getHeight(24),
                      ),

                      CustomButton(
                        onPressed: () {},
                        color: GlobalColor.grayTextField,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/intro/Group 108.png',
                              height: ScreenUtil.getHeight(22),
                              width: ScreenUtil.getWidth(22),
                            ),
                            const Text(
                              '   Sign up with Google',
                              style: GlobalText.textSmall,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.getHeight(55),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomClickText(
                                text: 'Already Have Account',
                                onPressed: moveToLogin,
                                textStyle: GlobalTextStyle.clickText
                                    .copyWith(color: GlobalColor.gray),
                              ),
                              const Text('? Log In'),
                            ],
                        ),
                      ),

                      SizedBox(
                        height: ScreenUtil.getHeight(47),
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
