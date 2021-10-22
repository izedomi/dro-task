import 'package:dro/screens/cart_screen.dart';
import 'package:dro/screens/categories_screen.dart';
import 'package:dro/screens/home.dart';
import 'package:dro/screens/not_found_screen.dart';
import 'package:dro/screens/onboarding.dart';
import 'package:dro/screens/pharmarcy_screen.dart';
import 'package:dro/screens/search_screen.dart';
import 'package:dro/utility/routes/route_paths.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //onboarding routes
      case RoutePaths.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RoutePaths.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case RoutePaths.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutePaths.pharmacy:
        return MaterialPageRoute(builder: (_) => const PharmacyScreen());
      case RoutePaths.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
