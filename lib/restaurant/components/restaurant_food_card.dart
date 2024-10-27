import 'package:flutter/material.dart';
import 'package:food_store/components/Card/x_card.dart';
import 'package:food_store/restaurant/model/restaurant_food.dart';
import 'package:food_store/routes/route_path.dart';
import 'package:food_store/utilities/helpers/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantFoodCard extends StatelessWidget {
  const RestaurantFoodCard({
    super.key,
    required this.food,
  });

  final RestaurantFood food;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePath.restaurantFood,
          arguments: food,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 0.1.w,
          ),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xFF1d102d),
              Colors.transparent,
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          width: 500.w,
          height: 110.h,
          child: Row(
            children: [
              Expanded(
                // width: 200.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    vGap(3),
                    Text(
                      food.description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    vGap(3),
                    Text(
                      '\$${food.price}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 100.h,
                    child: Image.asset(
                      food.imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: XCard(
                      backgroundColor: Colors.black54,
                      child: Icon(EvaIcons.plus),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
