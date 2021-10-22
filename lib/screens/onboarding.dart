import 'package:dro/utility/routes/route_paths.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String backgroundImage = "assets/images/logo.png";

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    Future.delayed(const Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, RoutePaths.home));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(color: white),
            width: deviceWidth(context),
            height: deviceHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage(backgroundImage),
                Styles.bold("DROHealth", color: txtPurple, fontSize: 30.sp),
                VSpace(16.h),
                Styles.regular("...all round quality healthcare")
              ],
            )));
  }

  Widget _buildImage(String assetName) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(120.0),
      child: Container(
        height: 200,
        width: 200,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120), color: Colors.white),
        child: Image(
          image: AssetImage(assetName),
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
