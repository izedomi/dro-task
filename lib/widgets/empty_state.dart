import 'package:dro/utility/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dro/utility/utils/colors.dart';

class EmptyState extends StatelessWidget {
  final String label;
  const EmptyState({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/empty_state.png",
            width: 314.w,
            height: 314.h,
          ),
          Styles.regular(label,
              fontSize: 20.sp, fontWeight: FontWeight.w600, color: altoGrey)
        ],
      ),
    );
  }
}
