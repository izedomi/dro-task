import 'package:dro/model/product.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/widgets/add_to_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'buttons/custom_outline_button.dart';
import 'product_sub_detail.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final bool? showButton;
  final bool? showPrescriptionOverlay;
  const ProductItem(
      {required this.product,
      this.showButton = false,
      this.showPrescriptionOverlay = true,
      Key? key})
      : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    //print("dlsk: " + getDisplayImage(product.image));
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.sp),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.sp),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 6.0,
                  color: Colors.black12,
                  spreadRadius: 3,
                  offset: Offset(2, 2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.product.image,
                  width: double.infinity,
                  height: 150.h,
                  fit: BoxFit.cover,
                  //height: ,
                ),
                widget.product.requiresPrescription &&
                        widget.showPrescriptionOverlay!
                    ? Positioned(
                        bottom: 0,
                        child: Container(
                          width: 160,
                          alignment: Alignment.center,
                          child: Styles.regular("Requires a prescription",
                              fontSize: 12.sp,
                              color: white,
                              fontWeight: FontWeight.w600,
                              align: TextAlign.center),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            VSpace(13.h),
            Padding(
              padding: EdgeInsets.only(left: 11.w, right: 11.w, bottom: 13.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Styles.regular(widget.product.name, color: bunkerBlack),
                  VSpace(2.h),
                  ProductSubDetail(
                      label1: widget.product.type,
                      label2: widget.product.packSize),
                  VSpace(9.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: '₦',
                            style: TextStyle(
                                color: bunkerBlack,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.product.price.toString(),
                                style: TextStyle(
                                    color: bunkerBlack,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      ),
                      widget.showButton!
                          ? const AddTOWishList()
                          : const SizedBox()
                    ],
                  ),
                  widget.showButton! ? VSpace(13.h) : const SizedBox(),
                  widget.showButton!
                      ? CustomOutlineButton("ADD TO CART", onTap: () {})
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
