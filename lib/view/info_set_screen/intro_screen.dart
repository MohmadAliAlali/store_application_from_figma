import 'package:flutter/material.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/state_manger.dart';
import 'package:task_5/core/widget/custom_button.dart';
import 'package:task_5/view/login_screen/login_screen.dart';

class IntroScreens extends StatefulWidget {
  const IntroScreens({super.key});

  @override
  IntroScreensState createState() => IntroScreensState();
}

class IntroScreensState extends State<IntroScreens> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> screens = [
    {
      'image': 'assets/intro/intro1.png',
      'title': 'Welcome To Programmer store',
      'description': '',
    },
    {
      'image': 'assets/intro/intro2.png',
      'title': 'Let’s Start Journey',
      'description': 'Smart, Gorgeous & Fashionable Collection Explore Now'
    },
    {
      'image': 'assets/intro/intro3.png',
      'title': 'You Have the Power To',
      'description':
          'There Are Many Beautiful And Attractive Plants To Your Room'
    },
  ];

  void _goToNextPage() {
    if (currentIndex < screens.length - 1) {
      _pageController.animateToPage(
        currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      AppState.firstUse();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen()),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: const Color(0xff282828),
      body: Stack(
        children: [
          Image.asset(
            screens[currentIndex]['image']!,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getWidth(30),
                    right: ScreenUtil.getWidth(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ScreenUtil.getHeight(298),
                    ),
                    SizedBox(
                      height: 89,
                      child: Text(
                        screens[currentIndex]['title']!,
                        style: GlobalTextStyle.heading,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                        height: ScreenUtil.getHeight(30)), // Responsive spacing
                    Text(
                      screens[currentIndex]['description']!,
                      style: GlobalTextStyle.body,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: screens.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: ScreenUtil.getHeight(812),
                  width: ScreenUtil.getWidth(375),
                );
              },
            ),
          ),
          Column(
            children: [
              SizedBox(height: ScreenUtil.getHeight(571),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  screens.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.getWidth(5)),
                    width: currentIndex == index
                        ? ScreenUtil.getWidth(42)
                        : ScreenUtil.getWidth(28),
                    height: ScreenUtil.getHeight(5),
                    decoration: BoxDecoration(
                      color:
                      currentIndex == index ? Colors.white : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                onPressed: _goToNextPage,
                height: ScreenUtil.getHeight(50),
                width: ScreenUtil.getWidth(335),
                child: Text(currentIndex == 0 ? 'Get Started' : 'Next',
                    style: GlobalTextStyle.btnText),
              ),
              SizedBox(
                height: ScreenUtil.getHeight(36),
              ),
            ],
          )
        ],
      ),
    );
  }
}
