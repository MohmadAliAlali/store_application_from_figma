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
import 'package:task_5/view/nav_pages/nav_pages.dart';
import 'package:task_5/view/rigister_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    String fcmToken = "1221244";

    var response = await _loginController.login(email, password, fcmToken);

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      moveTopNavPages();
      AppState.login();
    } else {
      _showErrorMessage("Login failed. Please check your credentials.");
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
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: GlobalColor.backgroundPage,
      appBar: AppBar(
        backgroundColor: GlobalColor.backgroundPage,
        leading: Navigator.canPop(context) ? CustomIcon(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: GlobalColor.iconColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ) : null,
      ),
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
                        'Hello Again!',
                        style: GlobalText.text30,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: ScreenUtil.getHeight(8),
                      ),
                      Text(
                        'Fill your details or continue with social media',
                        style: GlobalTextStyle.body.copyWith(color: GlobalColor.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              SizedBox(
                height: ScreenUtil.getHeight(30),
              ),
                Column(
                    children: [
                      CustomTextField(
                        text: 'Email Address',
                        controller: _emailController,
                        hintText: 'Enter your Email',
                        validator: (value) => GlobalValid.validEmail(value), //
                        paddingBtm:
                            ScreenUtil.getHeight(30), // Use the validator
                      ),
                      CustomTextField(
                        text: 'Password',
                        controller: _passwordController,
                        hintText: 'Enter your Password',
                        validator: (value) => GlobalValid.validPassword(value),
                        suffixIcon: Icons.remove_red_eye,
                        obscureText: obscureText,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12, bottom: 24),
                        width: ScreenUtil.getWidth(335),
                        alignment: Alignment.centerRight,
                        child: CustomClickText(
                          text: 'Recovery Password',
                          onPressed: () {},
                          textStyle: GlobalTextStyle.clickText,
                        ),
                      ),
                      CustomButton(
                        onPressed: _login,
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                'Sign In',
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
                              '   Sign In with Google',
                              style: GlobalText.textSmall,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.getHeight(135),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomClickText(
                            text: 'New User?',
                            onPressed: moveToSignup,
                            textStyle: GlobalTextStyle.clickText
                                .copyWith(color: GlobalColor.gray),
                          ),
                          const Text(' Create Account'),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil.getHeight(47),
                      ),
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }

  void moveToSignup() {
    Navigation.navigateTo(context, const RegisterScreen());
  }

  void moveTopNavPages() {
    Navigation.navigateAndRemove(context, const NavPages());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
