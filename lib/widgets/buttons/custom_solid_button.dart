import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSolidButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final bool? hasIcon;
  final Widget? icon;
  final Function() onTap;

  const CustomSolidButton(this.label,
      {Key? key,
      this.width,
      this.height,
      this.hasIcon = true,
      this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 364.w,
        height: height ?? 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: const [
              BoxShadow(
                color: shadowPurple,
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(4, 10),
              )
            ],
            gradient: const LinearGradient(
                colors: [Color(0xff7A08FA), Color(0xffAD3BFC)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon!
                ? icon ??
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 20.sp,
                      color: white,
                    )
                : Icon(
                    Icons.shopping_cart_outlined,
                    size: 20.sp,
                    color: white,
                  ),
            HSpace(5.w),
            Styles.bold(label, fontSize: 15.sp, color: white)
          ],
        ),
      ),
    );
  }
}
