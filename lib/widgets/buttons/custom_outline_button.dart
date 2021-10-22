import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final double? fontSize;
  final double? width;
  final double? height;
  final Function() onTap;

  const CustomOutlineButton(this.label,
      {Key? key, this.fontSize, this.width, this.height, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 40.h,
      child: OutlinedButton(
        onPressed: onTap,
        child:
            Styles.bold(label, color: lightPurple, fontSize: fontSize ?? 13.sp),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: const BorderSide(
            width: 1.0,
            color: lightPurple,
          ),
        ),
      ),
    );
  }
}
