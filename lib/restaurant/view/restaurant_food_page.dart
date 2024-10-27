import 'package:flutter/material.dart';
import 'package:food_store/components/Card/x_card.dart';
import 'package:food_store/components/button/action_button.dart';
import 'package:food_store/restaurant/model/restaurant_food.dart';
import 'package:food_store/routes/route_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_store/utilities/helpers/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:input_quantity/input_quantity.dart';

class RestaurantFoodPage extends StatelessWidget {
  const RestaurantFoodPage({
    super.key,
    required this.food,
  });

  final RestaurantFood food;

  static Route<dynamic> route(RestaurantFood food) {
    return RouteTransition.pageRouteBuilder(
      RestaurantFoodPage(
        food: food,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Stack(
        children: [
          CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              _sliverAppBar(context),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
            child: ActionBtn(
              text: 'Add to Basket',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _sliverAppBar(BuildContext context) {
    return SliverAppBar(
      clipBehavior: Clip.none,
      // collapsedHeight: 300.h,
      expandedHeight: 580.h,
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
                food.imgUrl,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 1.sw - 40.w,
                height: 245.h,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                padding: const EdgeInsets.all(20).w,
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
                    Text(
                      food.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    vGap(10),
                    Text(
                      '\$${food.price}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    vGap(10),
                    Text(
                      food.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UnconstrainedBox(
                        child: InputQty.int(
                          decoration: QtyDecorationProps(
                            contentPadding: EdgeInsets.all(10.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(
                                color: const Color(0xFF7F36DA),
                                width: 0.3.w,
                              ),
                            ),
                            btnColor: Colors.white,
                            iconColor: Colors.white,
                          ),
                          qtyFormProps: const QtyFormProps(
                            cursorColor: Colors.white,
                          ),
                          onQtyChanged: (val) {
                            // print(val.runType); // int
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
