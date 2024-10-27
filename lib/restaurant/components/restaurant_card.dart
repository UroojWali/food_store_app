import 'package:flutter/material.dart';
import 'package:food_store/components/Card/x_card.dart';
import 'package:food_store/restaurant/model/restaurant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_store/routes/route_path.dart';
import 'package:food_store/utilities/helpers/gap.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePath.restaurant,
          arguments: restaurant,
        );
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderOnForeground: true,
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Image.asset(
              restaurant.restaurantThumbnail,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    vGap(5),
                    if (restaurant.mainCourse != null) ...[
                      Text(restaurant.mainCourse!),
                      vGap(5),
                    ],
                    Row(
                      children: [
                        Text('\$${restaurant.deliveryFee} delivery fee'),
                        hGap(10),
                        Text('${restaurant.avgDeliveryTime} min'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: XCard(
                child: Text(
                  restaurant.rating.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
