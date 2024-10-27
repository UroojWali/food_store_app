import 'package:flutter/material.dart';
import 'package:food_store/components/Card/x_card.dart';
import 'package:food_store/restaurant/components/restaurant_food_card.dart';
import 'package:food_store/restaurant/model/restaurant.dart';
import 'package:food_store/routes/route_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_store/utilities/helpers/gap.dart';
import 'package:icons_plus/icons_plus.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final Restaurant restaurant;

  static Route<dynamic> route(Restaurant restaurant) {
    return RouteTransition.pageRouteBuilder(
      RestaurantPage(
        restaurant: restaurant,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [
          _sliverAppBar(context),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            sliver: SliverList.separated(
              itemCount: restaurant.foods.length,
              itemBuilder: (context, index) {
                final food = restaurant.foods[index];
                return RestaurantFoodCard(food: food);
              },
              separatorBuilder: (context, index) {
                return vGap(10);
              },
            ),
          )
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar(BuildContext context) {
    return SliverAppBar(
      clipBehavior: Clip.none,
      // collapsedHeight: 300.h,
      expandedHeight: 340.h,
      primary: true,
      floating: true,
      pinned: true,
      snap: true,
      stretch: false,
      leading: XCard(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(HeroIcons.arrow_left),
      ),
      actions: [
        XCard(
          onTap: () {},
          child: const Icon(HeroIcons.heart),
        ),
        XCard(
          onTap: () {},
          child: const Icon(HeroIcons.ellipsis_horizontal),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                restaurant.restaurantThumbnail,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 5,
              child: Container(
                width: 1.sw - 40.w,
                height: 145.h,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                padding: const EdgeInsets.all(10).w,
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  border: Border.all(
                    color: Colors.white,
                    width: 0.1.w,
                  ),
                  borderRadius: BorderRadius.circular(25.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x96312370),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.5.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: Colors.black,
                            child: Image.asset(restaurant.restaurantLogo),
                          ),
                        ),
                        hGap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 220.w,
                                  child: Text(
                                    restaurant.address,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    HeroIcons.chevron_right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    vGap(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _restaurantDetailColumn(
                            'Delivery Fee',
                            '\$${restaurant.deliveryFee}',
                          ),
                          Container(
                            color: Colors.white24,
                            height: 30.h,
                            width: 1.w,
                          ),
                          _restaurantDetailColumn(
                            'Avg. Delivery Time',
                            '${restaurant.avgDeliveryTime}',
                          ),
                          Container(
                            color: Colors.white24,
                            height: 30.h,
                            width: 1.w,
                          ),
                          _restaurantDetailColumn(
                            'Rating',
                            '${restaurant.rating}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _restaurantDetailColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 12.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
