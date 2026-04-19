import 'package:flutter/material.dart';

class ResponsiveShell extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveShell({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });
//it returs the true or false value based on the condition
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width <= 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1024;

  @override
  Widget build(BuildContext context) {
    //here layoutbuilder is decide which device is to be render
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return desktop;
        } else if (constraints.maxWidth >= 600) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
