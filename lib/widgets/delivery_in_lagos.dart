import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryInLagos extends StatelessWidget {
  const DeliveryInLagos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      color: tickGrey,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          const Icon(Icons.map),
          HSpace(6.w),
          RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: 'Delivery in ',
                style: TextStyle(
                    color: bunkerBlack,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                    text: "Lagos, Nigeria",
                    style: TextStyle(
                        color: bunkerBlack,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
