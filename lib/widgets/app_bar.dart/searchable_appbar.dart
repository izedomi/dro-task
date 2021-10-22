import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchableAppBar extends StatelessWidget {
  final bool canSearch;
  final Function()? navigateToSearchScreen;
  final Function? searchProduct;

  const SearchableAppBar(
      {this.canSearch = false,
      this.navigateToSearchScreen,
      this.searchProduct,
      Key? key})
      : super(key: key);

  //final TextEditingController _controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
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
                            size: 24, color: white),
                      ),
                      HSpace(10.w),
                      Styles.bold("Pharmacy", color: white, fontSize: 22.sp),
                    ],
                  ),
                  Image.asset("assets/images/truck.png",
                      width: 25.w, height: 22.h)
                ],
              ),
              SizedBox(height: 24.h),
              canSearch ? searchContent(context) : pharmacyContent(context)
            ],
          )),
    );
  }

  Widget searchContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 8,
          child: Container(
            height: 48.h,
            alignment: Alignment.center,
            child: TextField(
              style: const TextStyle(color: white),
              decoration: InputDecoration(
                // isDense: true,
                // isCollapsed: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "Search",
                hintStyle: const TextStyle(color: white),
                fillColor: const Color.fromRGBO(255, 255, 255, 0.3),
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onChanged: (value) {
                if (searchProduct != null) {
                  searchProduct!(value);
                }
              },
            ),
          ),
        ),
        Flexible(
            flex: 2,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Styles.regular("Cancel",
                  fontSize: 18.sp, color: white, fontWeight: FontWeight.w600),
            )),
      ],
    );
  }

  Widget pharmacyContent(BuildContext context) {
    return InkWell(
      onTap: () {
        if (navigateToSearchScreen != null) {
          navigateToSearchScreen!();
        }
      },
      child: Container(
        height: 48.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(10.sp)),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            HSpace(12.w),
            Styles.regular("Search",
                color: white, fontSize: 18.sp, fontWeight: FontWeight.w600)
          ],
        ),
      ),
    );
  }
}
