import 'package:badges/badges.dart';
import 'package:dro/bloc/cart_bloc_provider.dart';
import 'package:dro/model/cart.dart';
import 'package:dro/screens/cart_screen.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedAppBar extends StatelessWidget {
  const SharedAppBar({required this.title, this.hasCartIcon = true, Key? key})
      : super(key: key);
  final String title;
  final bool hasCartIcon;

  @override
  Widget build(BuildContext context) {
    final cartBloc = CartBlocProvider.of(context)!.cartBloc;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.sp),
          bottomRight: Radius.circular(16.sp)),
      child: Container(
          width: deviceWidth(context),
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
          decoration: BoxDecoration(
              color: txtPurple,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.sp),
                  bottomRight: Radius.circular(16.sp))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.chevron_left,
                            size: 30, color: white),
                      ),
                      HSpace(10.w),
                      Styles.bold(title, color: white, fontSize: 22.sp),
                    ],
                  ),
                  hasCartIcon
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              // MaterialPageRoute(builder: (context) => CreateAccount()),
                              MaterialPageRoute(
                                  builder: (context) => const CartScreen()),
                            );
                          },
                          child: Badge(
                            badgeColor: Colors.yellow,
                            position: BadgePosition.topEnd(top: -10, end: -8),
                            badgeContent: StreamBuilder<List<Cart>>(
                                stream: cartBloc.cartListStream,
                                initialData: const [],
                                builder: (context, snapshot) {
                                  return Styles.extraBold(
                                      "${snapshot.data!.length}",
                                      fontSize: 12.sp);
                                }),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          )),
    );
  }
}
