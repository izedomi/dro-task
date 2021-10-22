import 'package:dro/bloc/cart/cart_bloc.dart';
import 'package:dro/bloc/cart_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/onboarding.dart';
import 'utility/routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: () {
          return CartBlocProvider(
              cartBloc: CartBloc(),
              child: MaterialApp(
                  title: 'DRO Health',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      primarySwatch: Colors.purple,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      primaryColor: Colors.purple,
                      fontFamily: "ProximaNova"),
                  home: const OnboardingScreen(),
                  onGenerateRoute: AppRouter.generateRoute));
        });
  }
}
