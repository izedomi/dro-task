import 'package:dro/utility/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTOWishList extends StatelessWidget {
  const AddTOWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(159, 93, 226, 0.1),
            borderRadius: BorderRadius.circular(6.sp)),
        child: const Icon(Icons.favorite_border, size: 18, color: lightPurple));
  }
}
