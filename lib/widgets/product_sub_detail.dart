import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSubDetail extends StatelessWidget {
  final String label1;
  final String label2;

  const ProductSubDetail({required this.label1, required this.label2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Styles.regular(label1, fontSize: 14.sp, color: lightGrey),
        HSpace(6.w),
        Container(
          height: 6.h,
          width: 6.w,
          decoration:
              const BoxDecoration(color: mercuryGrey, shape: BoxShape.circle),
        ),
        HSpace(6.w),
        Styles.regular(label2, fontSize: 14.sp, color: lightGrey),
      ],
    );
  }
}
