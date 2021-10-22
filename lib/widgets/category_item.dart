import 'package:dro/model/category.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatefulWidget {
  final Category category;
  const CategoryItem({required this.category, Key? key}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.sp),
            child: Image.asset(
              widget.category.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(20.sp),
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Styles.bold(widget.category.title,
              fontSize: 15, color: white, align: TextAlign.center),
        ),
      ],
    );
  }
}
