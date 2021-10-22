import 'package:dro/utility/routes/route_paths.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:dro/widgets/buttons/custom_outline_button.dart';
import 'package:dro/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        color: white,
        padding: EdgeInsets.symmetric(horizontal: 36.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmptyState(label: "Page Not Found"),
            const VSpace(24),
            CustomOutlineButton("Go Back Home",
                onTap: () => Navigator.pushNamed(context, RoutePaths.home))
          ],
        ),
      ),
    );
  }
}
