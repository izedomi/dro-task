import 'package:dro/model/category.dart';
import 'package:dro/utility/data/category_list.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:dro/widgets/app_bar.dart/shared_appbar.dart';
import 'package:dro/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.h),
          child: const SharedAppBar(
            title: "Categories",
          )),
      body: SizedBox(
          width: deviceWidth(context),
          height: deviceHeight(context), //const Color(0xffF2F2F2),
          child: Column(
            children: [
              Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 30.h),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      //physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 1.4),
                      itemBuilder: (BuildContext context, int index) {
                        Category category = categories[index];
                        return CategoryItem(category: category);
                      }))
            ],
          )),
    );
  }
}
