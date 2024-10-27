import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_store/utilities/helpers/gap.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.image,
    required this.categoryName,
  });

  final Image image;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // width: 100.w,
      // height: 10.h,
      // height: 200.h,
      // color: Colors.red,
      padding: EdgeInsets.only(right: 15.w),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 66, 48, 117),
                width: 2.w,
              ),
              color: const Color(0xFF181030),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: image,
          ),
          vGap(10),
          Text(categoryName),
        ],
      ),
    );
  }
}
