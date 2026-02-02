import 'package:responsive_framework/responsive_framework.dart' ;
import 'package:flutter/material.dart';

class Responsive {
  static Widget responsiveWrapperBuilder(Widget child) {
    return ResponsiveWrapper.builder(
      child,
      maxWidth: 1200,
      minWidth: 450,
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(450, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
    );
  }
}
class ScreenUtil {
  static late double screenWidth;
  static late double screenHeight;

  static double screenWidthUI = 375;
  static double screenHeightUI = 812;

  static void init(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }

  static double getScaleFactor() {
    double widthScale = screenWidth / screenWidthUI;
    double heightScale = screenHeight / screenHeightUI;
    return (widthScale + heightScale) / 2;
  }

  static double getWidth(double designWidth) {
    return designWidth * getScaleFactor();
  }

  static double getHeight(double designHeight) {
    return designHeight * getScaleFactor();
  }
}